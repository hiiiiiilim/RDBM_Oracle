CREATE TABLE USER_INFO 
(
  USER_ID NUMBER(5) NOT NULL 
, USER_NAME VARCHAR2(20) 
, USER_MAIL VARCHAR2(20) 
);

COMMENT ON COLUMN USER_INFO.USER_ID IS '저장된순서';

COMMENT ON COLUMN USER_INFO.USER_NAME IS '유저이름';
