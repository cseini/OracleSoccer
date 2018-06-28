--1번
SELECT COUNT(*) AS "테이블의 수"
FROM TAB;

--2번
SELECT TEAM_NAME "전체 축구팀 목록"
FROM TEAM
order by team_name;

--3번
SELECT DISTINCT NVL2(position,position,'신입') 포지션
FROM player;

--4번
SELECT player_name 이름
FROM player
WHERE team_id = 'K02'
    AND position = 'GK'
ORDER BY player_name;

--5번
SELECT position 포지션, player_name 이름
FROM player
WHERE team_id LIKE 'K02'
    AND height >= 170
    AND SUBSTR(player_name, 0,1) LIKE '고'
;

--6번
SELECT player_name||'선수' 이름, 
    NVL2(height,height||'cm',0||'cm') 키, 
    NVL2(weight,weight||'kg',0||'kg') 몸무게
FROM player
WHERE team_id LIKE 'K02'
ORDER BY height DESC
;

--7번
SELECT player_name||'선수' 이름, 
    NVL2(height,height,0)||'cm' 키, 
    NVL2(weight,weight,0)||'kg' 몸무게, 
    ROUND(weight/(height*height)*10000,2) "BMI 비만지수"
FROM player
WHERE team_id LIKE 'K02'
ORDER BY height DESC
;

--8번
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

--w3 예제
SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders
    JOIN Customers
        ON Orders.CustomerID=Customers.CustomerID;

--9번 oracle
select p.height||'cm' 키, t.team_name 팀명, p.player_name 이름
from team t, player p
where t.team_id like p.team_id
    and t.team_id in('K02','K10')
    and p.height between 180 and 183
order by p.height, t.team_name, p.player_name;

--9번 ansi
select p.height||'cm' 키, t.team_name 팀명, p.player_name 이름
from player p
    join team t
    on t.team_id like p.team_id
where t.team_id in('K02','K10')
    and p.height between 180 and 183 
order by p.height, t.team_name, p.player_name;

--10번
select t.team_name, p.player_name
from player p
    join team t
    on t.team_id like p.team_id
where p.position is null 
order by t.team_name, p.player_name;

--11번
select t.team_name 팀이름, s.stadium_name 스타디움
from stadium s
    join team t
    on s.stadium_id like t.stadium_id
order by t.team_name;
    
--12번
select t.team_name 팀명, st.stadium_name 스타디움, sc.awayteam_id 원정팀ID, sc.sche_date 스케줄날짜
from schedule sc
    join stadium st
    on sc.stadium_id like st.stadium_id
    join team t
    on st.stadium_id like t.STADIUM_ID
where sc.sche_date like '20120317'
order by t.team_name;

--13번
select p.player_name 선수명, p.position 포지션, t.region_name||' '||t.team_name 팀명,st.stadium_name 스타디움, sc.sche_date 스케줄날짜
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


--14번
select st.stadium_name 스타디움,
        sc.sche_date 경기날짜,
        ht.REGION_NAME||' '||ht.team_name 홈팀,
        at.REGION_NAME||' '||at.team_name 원정팀,
        sc.home_score "홈팀 점수",
         sc.away_score "원정팀 점수"
from schedule sc
    join stadium st
        on sc.stadium_id like st.stadium_id
    join team ht
        on sc.hometeam_id like ht.team_id
    join team at
        on sc.awayteam_id like at.team_id
where sc.home_score - sc.away_score >= 3
order by sc.sche_date;

select st.stadium_name 스타디움,
        sc.sche_date 경기날짜,
        ht.REGION_NAME||' '||ht.team_name 홈팀,
        at.REGION_NAME||' '||at.team_name 원정팀,
        sc.home_score "홈팀 점수",
         sc.away_score "원정팀 점수"
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

--15번
select st.stadium_name 스타디움, st.stadium_id 스타디움id, st.seat_count 좌석수, st.hometeam_id 홈팀id, t.e_team_name 영어이름
from stadium st
    left join team t
        on st.stadium_id like t.STADIUM_ID
order by st.hometeam_id
;

--15번 union 최악, or 차악, in('K02','K07')로 해라

-- SOCCER_SQL_016
-- 소속이 삼성블루윙즈 팀인 선수들과
-- 드래곤즈팀인 선수들의 선수 정보
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ('K02' ,'K07')
;

-- 17번 K02, K07을 모르고 팀이름만 알때
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ((SELECT TEAM_ID
                   FROM TEAM 
                   WHERE TEAM_NAME IN ('삼성블루윙즈', '드래곤즈')))
;

SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P,
   (SELECT TEAM_ID, TEAM_NAME
        FROM TEAM 
        WHERE TEAM_NAME IN ('삼성블루윙즈', '드래곤즈')) T
WHERE 
    T.TEAM_ID LIKE P.TEAM_ID
;
--018 최호진 선수의 소속팀과 포지션, 백넘버는 무엇입니까
SELECT P.PLAYER_NAME, T.TEAM_NAME, P.POSITION, P.BACK_NO
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID
WHERE P.PLAYER_NAME LIKE '최호진'
;

--019 대전시티즌의 MF 평균키는 얼마입니까
SELECT P.POSITION 포지션, avg(P.HEIGHT) 평균키
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID
WHERE T.TEAM_ID LIKE (SELECT TEAM_ID
                      FROM TEAM
                      WHERE TEAM_NAME LIKE '시티즌')
    AND P.POSITION LIKE 'MF'
;
SELECT ROUND(AVG(P.HEIGHT),1)
FROM PLAYER P
WHERE P.POSITION LIKE 'MF'
;

--020 2012년 월별 경기수를 구하시오
SELECT COUNT(M3.SCHE_DATE) "3월",
       COUNT(M4.SCHE_DATE) "4월"
     
FROM SCHEDULE M3,
     SCHEDULE M4
WHERE M3.SCHE_DATE BETWEEN 20120300 AND 20120401
    AND M4.SCHE_DATE BETWEEN 20120400 AND 20120501
;
SELECT COUNT(M3.SCHE_DATE) "3월"
FROM SCHEDULE M3
WHERE M3.SCHE_DATE BETWEEN 20120300 AND 20120401;

SELECT * FROM SCHEDULE
ORDER BY SCHE_DATE;

--021 2012년 월별 진행된 경기수(GUBUN IS YES) 를 구하시오
--출력은 1월120경기 이런식으로

--022
--2012년 9월 14일에 벌어질 경기는 어디와 어디입니까
-- 홈팀:? 원정팀 :? 로 출력