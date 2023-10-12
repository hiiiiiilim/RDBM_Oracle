--1.
select department_name as "학과 명", category as 계열
from tb_department;

--2.
select department_name||'의 정원은 'as "학과 별 정원", capacity ||'명 입니다.' as " "
from tb_department;

--3. 
select *
from tb_student
where absence_yn ='Y' and department_no=001 and substr(STUDENT_SSN,8,1)=2;

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_SSN, 8, 1) = 2
      AND ABSENCE_YN = 'Y'
      AND DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                           FROM TB_DEPARTMENT
                           WHERE DEPARTMENT_NAME = '국어국문학과');

SELECT STUDENT_NAME
FROM TB_STUDENT
    LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과'
      AND SUBSTR(STUDENT_SSN, 8, 1) = 2
      AND ABSENCE_YN = 'Y';

--4.
select student_name
from tb_student
where student_no in ('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

--5.
select department_name, capacity
from tb_department
where capacity between 20 and 30;

--6. 
select professor_name
from tb_professor
where department_no is null;

--7.
select *
from tb_student
where department_no is null;

--8.
select class_no
from tb_class
where PREATTENDING_CLASS_NO is not null;

--9.
select distinct category
from tb_department
order by category;

--10.
select student_no, student_name, student_ssn
from tb_student
where absence_yn =  'N'
and student_no like 'A2%'
and student_address like '전주%';

SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) = 2002
      AND STUDENT_ADDRESS LIKE '%전주%'
      AND ABSENCE_YN = 'N';