drop table if exists consultation_items;
drop table if exists consultations;
drop table if exists maintenance_schedules;
drop table if exists public.news;
drop table if exists public.users;

-- 유저정보: 유저에 관한 기본정보
create table public.users (
  id bigint generated always as identity primary key,    -- 유저 번호: 다른 테이블에서 유저를 참조할 때 사용
  plate text not null unique,                            -- 번호판: 중복 등록 금지 (예: 12가 3456)
  name text not null,                                    -- 유저 닉네임 (예: 김개똥)
  user_type text check (user_type in ('GM', '유저')),    -- 유저타입: GM 또는 유저, 모르면 비워 둠(NULL)
  level integer check (level >= 1),                      -- 레벨: 숫자로 저장 (예: 33), 모르면 비워 둠(NULL)
  gender text check (gender in ('여자', '남자')),         -- 성별: 여자 또는 남자, 모르면 비워 둠(NULL)
  billing bigint not null default 0 check (billing >= 0) -- 누적 과금금액: 기본값 0, 음수 금지
);

alter table public.users enable row level security;

-- 주요 뉴스
create table public.news (
  id bigint generated always as identity primary key,
  title text not null,                            -- 뉴스 제목
  summary text,                                   -- 간단한 요약
  article_url text not null,                      -- 원문 기사 링크
  image_url text,                                 -- 썸네일 이미지 링크
  published_at timestamptz not null default now() -- 발행 시각
);

alter table public.news enable row level security;

-- 게임 직업: 직업 소개 페이지에서 사용
create table public.game_classes (
  id bigint generated always as identity primary key,   -- 직업 고유 번호
  name text not null unique,                            -- 직업 이름: 중복 금지
  description text not null,                            -- 직업 소개와 특징
  image_url text,                                       -- 직업 이미지 주소, 없으면 비워 둠(NULL)
  display_order integer not null unique
    check (display_order between 1 and 8)               -- 표시 순서: 1~8, 중복 금지
);
alter table public.game_classes enable row level security;

-- 게임 영상: 영상 소개 페이지에서 사용
create table public.game_videos (
  id bigint generated always as identity primary key, -- 영상 고유 번호
  title text not null,                                -- 영상 제목 (예: 공식 트레일러)
  description text,                                   -- 영상 소개, 없으면 비워 둠(NULL)
  video_url text not null,                            -- 영상 주소 (예: 유튜브 링크 또는 영상 파일 URL)
  thumbnail_url text,                                 -- 썸네일 이미지 주소, 없으면 비워 둠(NULL)
  display_order integer not null default 0
    check (display_order >= 0),                       -- 표시 순서: 작은 숫자부터 먼저 표시
  created_at timestamptz not null default now()       -- 등록 시각: 입력하지 않으면 현재 시각
);
alter table public.game_videos enable row level security;
