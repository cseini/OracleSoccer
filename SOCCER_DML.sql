--1��
SELECT COUNT(*) AS "���̺��� ��"
FROM TAB;

--2��
SELECT TEAM_NAME "��ü �౸�� ���"
FROM TEAM
order by team_name;

--3��
SELECT DISTINCT NVL2(position,position,'����') ������
FROM player;

--4��
SELECT player_name �̸�
FROM player
WHERE team_id = 'K02'
    AND position = 'GK'
ORDER BY player_name;

--5��
SELECT position ������, player_name �̸�
FROM player
WHERE team_id LIKE 'K02'
    AND height >= 170
    AND SUBSTR(player_name, 0,1) LIKE '��'
;

--6��
SELECT player_name||'����' �̸�, 
    NVL2(height,height||'cm',0||'cm') Ű, 
    NVL2(weight,weight||'kg',0||'kg') ������
FROM player
WHERE team_id LIKE 'K02'
ORDER BY height DESC
;

--7��
SELECT player_name||'����' �̸�, 
    NVL2(height,height,0)||'cm' Ű, 
    NVL2(weight,weight,0)||'kg' ������, 
    ROUND(weight/(height*height)*10000,2) "BMI ������"
FROM player
WHERE team_id LIKE 'K02'
ORDER BY height DESC
;

--8��
select t.team_name, p.position, p.player_name
from team  t
    join PLAYER p
    on t.TEAM_ID like p.TEAM_ID
where p.team_id IN ('K02','K10') 
    and p.position like 'GK'
order by t.team_name, p.player_name
;

--ansi
select t.team_name, p.position, p.player_name
from player p
    join team t
        on t.team_id like p.team_id
where t.team_id IN ('K02','K10') 
    and p.position like 'GK'
order by t.team_name, p.player_name;

--w3 ����
SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders
    JOIN Customers
        ON Orders.CustomerID=Customers.CustomerID;

--9�� oracle
select p.height||'cm' Ű, t.team_name ����, p.player_name �̸�
from team t, player p
where t.team_id like p.team_id
    and t.team_id in('K02','K10')
    and p.height between 180 and 183
order by p.height, t.team_name, p.player_name;

--9�� ansi
select p.height||'cm' Ű, t.team_name ����, p.player_name �̸�
from player p
    join team t
    on t.team_id like p.team_id
where t.team_id in('K02','K10')
    and p.height between 180 and 183 
order by p.height, t.team_name, p.player_name;

--10��
select t.team_name, p.player_name
from player p
    join team t
    on t.team_id like p.team_id
where p.position is null 
order by t.team_name, p.player_name;

--11��
select t.team_name ���̸�, s.stadium_name ��Ÿ���
from stadium s
    join team t
    on s.stadium_id like t.stadium_id
order by t.team_name;
    
--12��
select t.team_name ����, st.stadium_name ��Ÿ���, sc.awayteam_id ������ID, sc.sche_date �����ٳ�¥
from schedule sc
    join stadium st
    on sc.stadium_id like st.stadium_id
    join team t
    on st.stadium_id like t.STADIUM_ID
where sc.sche_date like '20120317'
order by t.team_name;

--13��
select p.player_name ������, p.position ������, t.region_name||' '||t.team_name ����,st.stadium_name ��Ÿ���, sc.sche_date �����ٳ�¥
from schedule sc
    join stadium st
    on sc.stadium_id like st.stadium_id
    join team t
    on sc.stadium_id like t.stadium_id
    join player p
    on t.TEAM_ID like p.TEAM_ID
where sc.SCHE_DATE like '20120317'
    and t.team_id like 'K03'
    and p.position like 'GK'
order by p.player_name;


--14��
select st.stadium_name ��Ÿ���,
        sc.sche_date ��⳯¥,
        ht.REGION_NAME||' '||ht.team_name Ȩ��,
        at.REGION_NAME||' '||at.team_name ������,
        sc.home_score "Ȩ�� ����",
         sc.away_score "������ ����"
from schedule sc
    join stadium st
        on sc.stadium_id like st.stadium_id
    join team ht
        on sc.hometeam_id like ht.team_id
    join team at
        on sc.awayteam_id like at.team_id
where sc.home_score - sc.away_score >= 3
order by sc.sche_date;

select st.stadium_name ��Ÿ���,
        sc.sche_date ��⳯¥,
        ht.REGION_NAME||' '||ht.team_name Ȩ��,
        at.REGION_NAME||' '||at.team_name ������,
        sc.home_score "Ȩ�� ����",
         sc.away_score "������ ����"
from (SELECT STADIUM_ID, SCHE_DATE, HOMETEAM_ID, AWAYTEAM_ID, HOME_SCORE, AWAY_SCORE
      FROM SCHEDULE
      WHERE home_score - away_score >= 3) sc
    join stadium st
        on sc.stadium_id like st.stadium_id
    join team ht
        on sc.hometeam_id like ht.team_id
    join team at
        on sc.awayteam_id like at.team_id
order by sc.sche_date;

--15��
select st.stadium_name ��Ÿ���, st.stadium_id ��Ÿ���id, st.seat_count �¼���, st.hometeam_id Ȩ��id, t.e_team_name �����̸�
from stadium st
    left join team t
        on st.stadium_id like t.STADIUM_ID
order by st.hometeam_id
;

--15�� union �־�, or ����, in('K02','K07')�� �ض�

-- SOCCER_SQL_016
-- �Ҽ��� �Ｚ������� ���� �������
-- �巡�������� �������� ���� ����
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ('K02' ,'K07')
;

-- 17�� K02, K07�� �𸣰� ���̸��� �˶�
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ((SELECT TEAM_ID
                   FROM TEAM 
                   WHERE TEAM_NAME IN ('�Ｚ�������', '�巡����')))
;

SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P,
   (SELECT TEAM_ID, TEAM_NAME
        FROM TEAM 
        WHERE TEAM_NAME IN ('�Ｚ�������', '�巡����')) T
WHERE 
    T.TEAM_ID LIKE P.TEAM_ID
;
--018 ��ȣ�� ������ �Ҽ����� ������, ��ѹ��� �����Դϱ�
SELECT P.PLAYER_NAME, T.TEAM_NAME, P.POSITION, P.BACK_NO
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID
WHERE P.PLAYER_NAME LIKE '��ȣ��'
;

--019 ������Ƽ���� MF ���Ű�� ���Դϱ�
SELECT P.POSITION ������, avg(P.HEIGHT) ���Ű
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID
WHERE T.TEAM_ID LIKE (SELECT TEAM_ID
                      FROM TEAM
                      WHERE TEAM_NAME LIKE '��Ƽ��')
    AND P.POSITION LIKE 'MF'
;
SELECT ROUND(AVG(P.HEIGHT),1)
FROM PLAYER P
WHERE P.POSITION LIKE 'MF'
;

--020 2012�� ���� ������ ���Ͻÿ�
SELECT COUNT(M3.SCHE_DATE) "3��",
       COUNT(M4.SCHE_DATE) "4��"
     
FROM SCHEDULE M3,
     SCHEDULE M4
WHERE M3.SCHE_DATE BETWEEN 20120300 AND 20120401
    AND M4.SCHE_DATE BETWEEN 20120400 AND 20120501
;
SELECT COUNT(M3.SCHE_DATE) "3��"
FROM SCHEDULE M3
WHERE M3.SCHE_DATE BETWEEN 20120300 AND 20120401;

SELECT * FROM SCHEDULE
ORDER BY SCHE_DATE;

--021 2012�� ���� ����� ����(GUBUN IS YES) �� ���Ͻÿ�
--����� 1��120��� �̷�������

--022
--2012�� 9�� 14�Ͽ� ������ ���� ���� ����Դϱ�
-- Ȩ��:? ������ :? �� ���