create table salary_info (
    employee_id NUMBER PRIMARY KEY,
    employee_name  VARCHAR2(50),
    salary NUMBER(10,2)
    );

INSERT INTO salary_info (employee_id, employee_name, salary)
VALUES (1, '�ɸӵ�', 50000.50);
INSERT INTO salary_info (employee_id, employee_name, salary)
VALUES (2, '�ٳ���', 60000.75);
INSERT INTO salary_info (employee_id, employee_name, salary)
VALUES (3, '�ڴٹ�', 80000.88);
INSERT INTO salary_info (employee_id, employee_name, salary)
VALUES (4, '�ư���', 70000.92);
INSERT INTO salary_info (employee_id, employee_name, salary)
VALUES (5, 'Ŀ��', 90000.92);


--id�� 1�� ������ �޿��� floor�Լ��� ����Ͽ� ����
select employee_id, employee_name, floor(salary) as f
from salary_info
where employee_id=1;

--employee_id�� 2�� ������ �޿�ceil �Լ��� ����ؼ� �ø�
select employee_id, employee_name,ceil(salary_info.salary) from salary_info
where employee_id =2;
--employee_id�� 3�� ������ �޿� round �Լ��� ����ؼ� �ݿø�
select employee_id, employee_name, round(salary) 
from salary_info
where employee_id=3;
--employee_id�� 4�� ������ �޿�floor �Լ��� ����ؼ� ����
select employee_id, employee_name, floor(salary) 
from salary_info
where employee_id=4;

--������ �޿��� 5000�̻��� ��� "���"���� ǥ��, �� �ܿ��� "����"���� ǥ��
select ename, salary,
    case -- ���������� ���� �� �ְ�, ������ �����ϴ� ��� �ٸ� ��� ��ȯ
        when salary >= 5000 then '���' --�޿��� 5000�̻��ΰ�� ����� ��ȯ
        else '����'                     --�� ���ǿ� �ش����� �ʴ� ��� �������� ��ȯ
    end as salary_info -- end �� case���� ���� ��Ÿ���� Ű����
                        --as salary_info ���� ������ ���� ��Ī �ο�
from employee; --employee���̺���

--���޿� ���� ���ʽ� ���
select ename, job, salary,
    case job
    when 'Manager' then salary*0.15
    when 'Developer' then salary*0.1
    when 'SalsesPerson' then salary*0.05
    else 0
    end as BONUS
from employee;

-- �޿��� ���� ���� 5000�̻� ���, 3000�̻� �߰�
select ename, 
    case 
    when salary >=5000 then '���'
    when salary >=3000 then '�߰�'
    else '����'
    end as range
from employee;

--������ �Ի��� ������ ���� ��� ���
select ename,
    case
        when EXTRACT(YEAR from hiredate)=2021 then'1�� �̸�'
        when extract(year from hiredate)=2022 then'1��'
        else '1���̻�'
        end as workyear
from employee

--������ �޿��� õ������ �ݿø�
select ename, round(salary, -4)
from employee;

--�޿��� ���� ��� ����
select ename, salary,
    case
        when salary >= 5000 then '���'
        when salary >= 3000 then '�߱�'
        else '�ʱ�'
        end as grade
from employee;
--�μ��� ���� �� ��� �� �μ���������, 3���� ��� �߱Ը� 5���� ��� ��Ը�
select dno, count(*),
    case
        when count(*)>=5 then '��Ը�'
        when count(*) >=3 then '�߱Ը�'
        else '�ұԸ�'
        end
from employee
group by dno
;
--������ �Ի� ���� ���� ��� ���
--(*10�� 1���� 9���� 2���� �������� 3�����̻�)
select ename,hiredate,
    case
        when EXTRACT(month from hiredate)=10 then'1����'
        when extract(month from hiredate)=9 then'2����'
        else '3���� �̻�'
        end as workmonth
from employee