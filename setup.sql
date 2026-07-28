-- ============================================
-- 英文單字配對遊戲 - Supabase 資料表設定
-- ============================================
-- 請在 Supabase SQL Editor 中執行這段 SQL
-- https://supabase.com/dashboard/project/dwfrqidfhpixqsjmdqzz/sql/new
-- ============================================

-- 1. 建立遊戲紀錄表格
CREATE TABLE IF NOT EXISTS game_records (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  seat_number TEXT NOT NULL,
  score INTEGER NOT NULL,
  game_time INTEGER NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 啟用 RLS（權限保護）
ALTER TABLE game_records ENABLE ROW LEVEL SECURITY;

-- 3. 允許學生寫入遊戲紀錄
CREATE POLICY "允許寫入遊戲紀錄" ON game_records
  FOR INSERT TO anon
  WITH CHECK (true);

-- 4. 允許讀取排行榜（所有人）
CREATE POLICY "允許讀取排行榜" ON game_records
  FOR SELECT TO anon
  USING (true);

-- 5. 驗證 RLS 已啟用
SELECT tablename, rowsecurity
FROM pg_tables
WHERE tablename = 'game_records' AND schemaname = 'public';
