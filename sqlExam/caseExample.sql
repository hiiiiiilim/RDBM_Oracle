create table salary_info (
    employee_id NUMBER PRIMARY KEY,
    employee_name  VARCHAR2(50),
    salary NUMBER(10,2)
    );

INSERT INTO salary_info (employee_id, employee_name, salary)
VALUES (1, '맴머드', 50000.50);
INSERT INTO salary_info (employee_id, employee_name, salary)
VALUES (2, '바나스', 60000.75);
INSERT INTO salary_info (employee_id, employee_name, salary)
VALUES (3, '박다밤', 80000.88);
INSERT INTO salary_info (employee_id, employee_name, salary)
VALUES (4, '맥가컾', 70000.92);
INSERT INTO salary_info (employee_id, employee_name, salary)
VALUES (5, '커피', 90000.92);


--id가 1인 직원의 급여를 floor함수를 사용하여 내림
select employee_id, employee_name, floor(salary) as f
from salary_info
where employee_id=1;

--employee_id가 2인 직원의 급여ceil 함수를 사용해서 올림
select employee_id, employee_name,ceil(salary_info.salary) from salary_info
where employee_id =2;
--employee_id가 3인 직원의 급여 round 함수를 사용해서 반올림
select employee_id, employee_name, round(salary) 
from salary_info
where employee_id=3;
--employee_id가 4인 직원의 급여floor 함수를 사용해서 내림
select employee_id, employee_name, floor(salary) 
from salary_info
where employee_id=4;

--직원의 급여가 5000이상인 경우 "고액"으로 표시, 그 외에는 "보통"으로 표시
select ename, salary,
    case -- 여러조건을 비교할 수 있고, 조건을 만족하는 경우 다른 결과 반환
        when salary >= 5000 then '고액' --급여가 5000이상인경우 고액을 반환
        else '보통'                     --위 조건에 해당하지 않는 경우 보통으로 반환
    end as salary_info -- end 는 case문의 끝을 나타내는 키워드
                        --as salary_info 새로 생성된 열에 별칭 부여
from employee; --employee테이블에서

--직급에 따라 보너스 계산
select ename, job, salary,
    case job
    when 'Manager' then salary*0.15
    when 'Developer' then salary*0.1
    when 'SalsesPerson' then salary*0.05
    else 0
    end as BONUS
from employee;

-- 급여의 범위 지정 5000이상 고액, 3000이상 중간
select ename, 
    case 
    when salary >=5000 then '고액'
    when salary >=3000 then '중간'
    else '보통'
    end as range
from employee;

--직원이 입사한 연도에 따른 경력 계산
select ename,
    case
        when EXTRACT(YEAR from hiredate)=2021 then'1년 미만'
        when extract(year from hiredate)=2022 then'1년'
        else '1년이상'
        end as workyear
from employee

--직원의 급여를 천단위로 반올림
select ename, round(salary, -4)
from employee;

--급여에 따른 등급 지정
select ename, salary,
    case
        when salary >= 5000 then '고급'
        when salary >= 3000 then '중급'
        else '초급'
        end as grade
from employee;
--부서별 직원 수 계산 및 부서유형지정, 3명일 경우 중규모 5명일 경우 대규모
select dno, count(*),
    case
        when count(*)>=5 then '대규모'
        when count(*) >=3 then '중규모'
        else '소규모'
        end
from employee
group by dno
;
--직원의 입사 월에 따른 경력 계산
--(*10월 1개월 9월은 2개월 나머지는 3개월이상)
select ename,hiredate,
    case
        when EXTRACT(month from hiredate)=10 then'1개월'
        when extract(month from hiredate)=9 then'2개월'
        else '3개월 이상'
        end as workmonth
from employee