--CREATE 
/*
CREATE TABLE FridayTABLE (
 id NUMBER(5) PRIMARY KEY,
 name VARCHAR2(50),
 description VARCHAR2(100),
 birthdate DATE
 );
 */
 --INSERT 문 
 --To Date 함수 사용해서 날짜 형식으로 데이터 삽입
 /*
 INSERT INTO fridaytable (id, name,description, birthdate)
 Values (1, '박창규', '금요일천사', TO_DATE('1970-05-25', 'YYYY-MM-DD'));
 INSERT INTO fridaytable (id, name, description, birthdate)
 VALUES (2, '나세희', '8월의 요정', TO_DATE('1997-08-16', 'YYYY-MM-DD')); 
  INSERT INTO fridaytable (id, name,description, birthdate)
 Values (3, '주서경', '11월의악마', TO_DATE('2002-11-29', 'YYYY-MM-DD'));
 INSERT INTO fridaytable (id, name, description, birthdate)
 VALUES (4, '김민수', '2월의 요정', TO_DATE('2000-02-07', 'YYYY-MM-DD')); 
  INSERT INTO fridaytable (id, name, description, birthdate)
 VALUES (5, '이미혜', '2월의 천사', TO_DATE('2001-02-09', 'YYYY-MM-DD')); 
 */
 --ORDER BY : 결과 정렬
 --이름을 오름차순으로 정렬
 SELECT * FROM fridaytable ORDER BY birthdate;
 
 --COUNT 행의 수를 세어줍니다.
 SELECT COUNT(*) AS row_COUNT FROM fridaytable;
 
 -- 테이블 구조 변경하기
 -- 열의 크기 늘리기
-- description 열의 크기를 늘리기
--ALTER TABLE fridaytable MODIFY description VARCHAR2(200);

 --SUM 숫자 열의 합을 계산
 --모든 id 값을 합산
 SELECT SUM(id) AS id_sum FROM fridaytable;
 
 --TO_CHAR 날짜를 문자열로 변환
 SELECT name, TO_CHAR(birthdate, 'YYYY-MM-DD') AS birthdate_str From fridaytable;
 
 --LENGTH : 문자열의 길이 반환
 SELECT description, LENGTH(description) AS name_len FROM fridaytable;
 
 INSERT INTO fridaytable (id, name, description, birthdate)
 VALUES (6, 'Jane Smith', '만나써 반가워요!', TO_DATE('2007-05-05', 'YYYY-MM-DD'));
 
 -- UPPER 문자열을 대문자로 변환
 SELECT name, UPPER(name) AS upper_name FROM fridaytable;
 -- LOWER 문자열을 소문자로 변환
 SELECT name, LOWER(name) AS lower_name FROM fridaytable;
 --ROUNT 숫자를 반올림
 --birthdate 열의 연도를 반올림하여 출력
 --EXTRACT 날짜 값에서 연도를 추출
 SELECT name, ROUND(EXTRACT(YEAR FROM birthdate)) AS BirthYEAR FROM fridaytable;


--NVL(Null Value) : null값을 다른 값으로 대체 할때 사용
 select ename, nvl(commission, 0) as commisson
 from employee;

--NEXT DAY다음 주어진 요일 날짜 찾기
select ename, next_day(sysdate, 'FRIDAY') as next_day 
from dual;

--TRUNC: 날짜 또는 숫자의 소수부 제거
select ename, trunc(salary) as TRUNC_SALARY from employee;

--Floor, CEIL, ROUND(반올림) 숫자 반올림 및 내림
select ename, floor(salary) as FLOOR_SALARY from employee;
select ename, CEIL(salary) as CEIL_SALARY from employee;
select ename, round(salary,2) as round_salary from employee;

--ABS 절대 값 계산 -를 없앰
select ename, abs(commission) as ABS_COMMITSSION 
FROM employee;

--WINDOW :  sql에서 사용되는 분석 함수, 결과 집합 내에서 행의 순서와 관련된 계산을 수행할 수 있음
            집계, 순위, 평균, 합계 등을 계산할때 유용
            데이터를 파티션별로 분할하고 순서를 정의한 다음 각 파티션 내에 계산을 수행
      <윈도우함수>(<표현식>)over 
      partition by <파티션열>
      order by <정렬 열>
      rows between <시작 행> and <끝 행>
  <윈도우함수>: 사용할 윈도우 함수 작성 ex) sum, av, rank등
  <표현식>: 계산을 수행할 열 또는 식
  partition by : 데이터를 파티션으로 나누는데 사용할 열을 지정
  order by: 각 파티션 내에서 행 순서를 정의하는데 사용할 열을 지정
  rows between : 계산을 수행할 행의 범위를 정의하는데 사용
select 
    order_id, order_date, total_price, 
    sum(total_price) over (order by order_date) as od --이부분이 윈도우 함수,
    --order_date를 기준으로 각 주문의 총 가격을 누적한 값을 반환한 것 결과 집합에는 order_id, order_date, total_price, od 열이 포함
    -- 각 주문에 대한 누적 가격을 계산할 수 있음
from orders;
   'rank() row_number(): 결과 집합의 행의 순위를 할당하는데 사용
   'rank()함수: 동일한 값이 있는 경우 동일한 순위 부여
               동일한 값이 여러번 나타나면 동일한 순위가 여러번 반복
               예를 들어 동일한 값을 가진 두번째와 세번째 행에 둘 다 2위 할당, 결과 집합에서 중간에 순위를 건너 뛸 수 있음
   'row_number(): 동일한 값이 있더라도 각행의 고유한 순위를 부여
                  동일한 값이 있는 경우에도 각 행에대해 중복되지 않는 순위 할당
                  예를 들어 동일한 값을 가진 두번째와 세번째 행에 대해 각각 2위와 3위할당 결과 집합에서 순서는 항상 연속적
   'rownum: 데이터베이스에서 사용할 수 있는 가상 열중 하나 
            검색 결과 집합의 각 행에 할당된 고유 번호를 나타냄
            결과 집합의 특정 행을 선택하거나 행에 번호를 할당하는데 사용
            특징: 검색 결과 집합을 처리하는 동안 생성됨, 결과 집합에 대한 각 행에 할당, 1부터 시작하여 각행에 연속된 정수 값을 부여
                 원하는 행을 선택하거나 행의 일련번호를 할당할 수 있지만 결과를 정렬하거나 분할하는 작업에 영향을 주지 않음
    'PIVOT : 데이터베이스 쿼리에서 사용되는 연산자 또는 기능, 행 데이터를 열데이터로 변환하는 작업을 수행
            데이터를 행과 열간에 변환해서 요약된 결과를 얻을 수 있음
            데이터를 어떤 열 기준으로 피벗할 지 정의
            데이터를 피벗하고 결과 집합을 새로운 열로 구성, 각 고유한 값은 열이름이 되며, 해당 값의 집계 결과가 해당 열에 배치
            결과 집합에는 기존 데이터의 행과 집계된 열이 포함
    
 -- lower  문자열을 소문자로 변경
 -- upper  문자열을 대문자로 변환
 -- initcap 각 단어의 첫글자를 대문자로 변환
 -- substr 문자열의 (1~5) 일부분 추출
 -- trim ' Hello, World ' 양쪽 공백 제거
 --ltrim ' Hello, World ' 왼쪽 공백제거
 --rtrim  ' Hello, World ' 오른쪽 공백제거
 --왼쪽에 문자열을 채우고 싶다. -> lpad활용
    select lpad('5',4,'0') from dual;

--문자열에서 특정 문자 또는 문자열을 다른 문자열로 대체
select replace (description, '풍미', '맛')from menu;
select product_name, replace(product_name, '스마트', '똑똑한')
from products;

--concat두문자열을 결합
select product_name || '가격 : $' || to_char(price, '999.99')
from products;

--substr 문자열 일부를 추출해줌
select product_name, substr(product_name, 1,3)
from products;
 
 
 
