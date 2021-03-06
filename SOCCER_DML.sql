/* Formatted on 2018/06/29 오후 4:23:46 (QP5 v5.326) */
-- SOCCER_SQL_001

SELECT COUNT (*) "테이블의 수" FROM TAB;

-- SOCCER_SQL_002

  SELECT TEAM_NAME     "전체 축구팀 목록"
    FROM TEAM
ORDER BY TEAM_NAME DESC;

-- SOCCER_SQL_003
-- 포지션 종류(중복제거,없으면 신입으로 기재)
-- NVL2()

SELECT DISTINCT NVL2 (POSITION, POSITION, '신입')     "포지션"
  FROM PLAYER;

-- SOCCER_SQL_004
-- 수원팀(ID: K02)골키퍼

  SELECT PLAYER_NAME     이름
    FROM PLAYER
   WHERE TEAM_ID = 'K02' AND POSITION = 'GK'
ORDER BY PLAYER_NAME;

-- SOCCER_SQL_005
-- 수원팀(ID: K02)키가 170 이상 선수
-- 이면서 성이 고씨인 선수

  SELECT POSITION 포지션, PLAYER_NAME 이름
    FROM PLAYER
   WHERE     HEIGHT >= 170
         AND TEAM_ID LIKE 'K02'
         AND SUBSTR (PLAYER_NAME, 0, 1) LIKE '고'
ORDER BY PLAYER_NAME;

-- SUBSTR('홍길동',2,2) 하면
-- 길동이 출력되는데
-- 앞2는 시작위치, 뒤2는 글자수를 뜻함

SELECT SUBSTR (PLAYER_NAME, 2, 2) 테스트값 FROM PLAYER;

-- 다른 풀이(권장)

  SELECT POSITION 포지션, PLAYER_NAME 이름
    FROM PLAYER
   WHERE HEIGHT >= 170 AND TEAM_ID LIKE 'K02' AND PLAYER_NAME LIKE '고%'
ORDER BY PLAYER_NAME;

-- SOCCER_SQL_006
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 CM 와 KG 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- 키 내림차순

  SELECT PLAYER_NAME || '선수'              이름,
         NVL2 (HEIGHT, HEIGHT, 0) || 'CM'     키,
         NVL2 (WEIGHT, WEIGHT, 0) || 'KG'     몸무게
    FROM PLAYER
   WHERE TEAM_ID LIKE 'K02'
ORDER BY HEIGHT DESC;

-- SOCCER_SQL_007
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 CM 와 KG 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- BMI지수
-- 키 내림차순

  SELECT PLAYER_NAME || '선수'
             이름,
         NVL2 (HEIGHT, HEIGHT, 0) || 'CM'
             키,
         NVL2 (WEIGHT, WEIGHT, 0) || 'KG'
             몸무게,
         ROUND (WEIGHT / ((HEIGHT / 100) * (HEIGHT / 100)), 2)
             "BMI 비만지수"
    FROM PLAYER
   WHERE TEAM_ID = 'K02'
ORDER BY HEIGHT DESC;

-- SOCCER_SQL_008
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- GK 포지션인 선수
-- 팀명, 사람명 오름차순

  SELECT T.TEAM_NAME, P.POSITION, P.PLAYER_NAME
    FROM PLAYER P, TEAM T
   WHERE     T.TEAM_ID = P.TEAM_ID
         AND T.TEAM_ID IN ('K02', 'K10')
         AND P.POSITION LIKE 'GK'
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;

-- ANSI JOIN 사용(권장)

  SELECT T.TEAM_NAME, P.POSITION, P.PLAYER_NAME
    FROM PLAYER P INNER JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
   WHERE T.TEAM_ID IN ('K02', 'K10') AND P.POSITION LIKE 'GK'
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;

-- SOCCER_SQL_009
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- 키가 180 이상 183 이하인 선수들
-- 키, 팀명, 사람명 오름차순

  SELECT P.HEIGHT || 'CM' 키, T.TEAM_NAME 팀명, P.PLAYER_NAME 이름
    FROM PLAYER P, TEAM T
   WHERE     T.TEAM_ID = P.TEAM_ID
         AND T.TEAM_ID IN ('K02', 'K10')
         AND P.HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT, T.TEAM_NAME, P.PLAYER_NAME;

-- ANSI JOIN 사용(권장)

  SELECT P.HEIGHT || 'CM' 키, T.TEAM_NAME 팀명, P.PLAYER_NAME 이름
    FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
   WHERE T.TEAM_ID IN ('K02', 'K10') AND P.HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT, T.TEAM_NAME, P.PLAYER_NAME;

-- SOCCER_SQL_010
--  모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순

  SELECT T.TEAM_NAME, P.PLAYER_NAME
    FROM PLAYER P, TEAM T
   WHERE P.POSITION IS NULL
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;

-- SOCCER_SQL_011
-- 팀이름, 스타디움 이름 출력

  SELECT T.TEAM_NAME 팀명, S.STADIUM_NAME 스타디움
    FROM STADIUM S JOIN TEAM T ON T.STADIUM_ID LIKE S.STADIUM_ID
ORDER BY T.TEAM_NAME;

-- SOCCER_SQL_012
-- 2012년 3월 17일에 열린 각 경기의
-- 팀이름, 스타디움, 어웨이팀 이름 출력



-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함),
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오

  SELECT P.PLAYER_NAME                            선수명,
         P.POSITION                               포지션,
         T.REGION_NAME || '  ' || T.TEAM_NAME     팀명,
         S.STADIUM_NAME                           스타디움,
         K.SCHE_DATE                              스케줄날짜
    FROM TEAM T
         JOIN STADIUM S ON T.STADIUM_ID LIKE S.STADIUM_ID
         JOIN PLAYER P ON T.TEAM_ID LIKE P.TEAM_ID
         JOIN SCHEDULE K ON S.STADIUM_ID LIKE K.STADIUM_ID
   WHERE     K.SCHE_DATE LIKE '20120317'
         AND P.POSITION LIKE 'GK'
         AND S.STADIUM_NAME LIKE '포항스틸야드'
ORDER BY P.PLAYER_NAME;

-- SOCCER_SQL_014
-- 홈팀이 3점이상 차이로 승리한 경기의
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오

  SELECT S.STADIUM_NAME                             스타디움,
         K.SCHE_DATE                                경기날짜,
         HT.REGION_NAME || '  ' || HT.TEAM_NAME     홈팀,
         AT.REGION_NAME || '  ' || AT.TEAM_NAME     원정팀,
         K.HOME_SCORE                               "홈팀 점수",
         K.AWAY_SCORE                               "원정팀 점수"
    FROM SCHEDULE K
         JOIN STADIUM S ON K.STADIUM_ID LIKE S.STADIUM_ID
         JOIN TEAM HT ON K.HOMETEAM_ID LIKE HT.TEAM_ID
         JOIN TEAM AT ON K.AWAYTEAM_ID LIKE AT.TEAM_ID
   WHERE K.HOME_SCORE >= K.AWAY_SCORE + 3
ORDER BY K.SCHE_DATE;

-- SOCCER_SQL_015
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록

  SELECT S.STADIUM_NAME,
         S.STADIUM_ID,
         S.SEAT_COUNT,
         S.HOMETEAM_ID,
         T.E_TEAM_NAME
    FROM STADIUM S LEFT JOIN TEAM T ON S.HOMETEAM_ID LIKE T.TEAM_ID
ORDER BY S.HOMETEAM_ID;

-- SOCCER_SQL_016
-- 소속이 삼성 블루윙즈 팀인 선수들과
-- 전남 드래곤즈팀인 선수들의 선수 정보
---- UNION VERSION

SELECT T.TEAM_NAME       팀명,
       P.PLAYER_NAME     선수명,
       P.POSITION        포지션,
       P.BACK_NO         백넘버,
       P.HEIGHT          키
  FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE T.TEAM_ID LIKE 'K02'
UNION
SELECT T.TEAM_NAME       팀명,
       P.PLAYER_NAME     선수명,
       P.POSITION        포지션,
       P.BACK_NO         백넘버,
       P.HEIGHT          키
  FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE T.TEAM_ID LIKE 'K07';

---- OR VERSION

SELECT T.TEAM_NAME       팀명,
       P.PLAYER_NAME     선수명,
       P.POSITION        포지션,
       P.BACK_NO         백넘버,
       P.HEIGHT          키
  FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE T.TEAM_ID LIKE 'K02' OR T.TEAM_ID LIKE 'K07';

---- IN VERSION

SELECT T.TEAM_NAME       팀명,
       P.PLAYER_NAME     선수명,
       P.POSITION        포지션,
       P.BACK_NO         백넘버,
       P.HEIGHT          키
  FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE T.TEAM_ID IN ('K02', 'K07');

-- SOCCER_SQL_017
-- 소속이 삼성 블루윙즈 팀인 선수들과
-- 전남 드래곤즈팀인 선수들의 선수 정보
---- SUBQUERY VERSION

SELECT T.TEAM_NAME       팀명,
       P.PLAYER_NAME     선수명,
       P.POSITION        포지션,
       P.BACK_NO         백넘버,
       P.HEIGHT          키
  FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE T.TEAM_ID IN
           ((SELECT TEAM_ID
               FROM TEAM
              WHERE TEAM_NAME IN ('삼성블루윙즈', '드래곤즈')));

SELECT T.TEAM_NAME       팀명,
       P.PLAYER_NAME     선수명,
       P.POSITION        포지션,
       P.BACK_NO         백넘버,
       P.HEIGHT          키
  FROM PLAYER  P,
       (SELECT TEAM_ID, TEAM_NAME
          FROM TEAM
         WHERE TEAM_NAME IN ('삼성블루윙즈', '드래곤즈')) T
 WHERE T.TEAM_ID LIKE P.TEAM_ID;

-- 018
-- 최호진 선수의 소속팀과 포지션, 백넘버는 무엇입니까

SELECT T.TEAM_NAME 팀명, P.POSITION 포지션, P.BACK_NO 백넘버
  FROM PLAYER P JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
 WHERE P.PLAYER_NAME LIKE '최호진';

--019 대전시티즌의 MF 평균키는 얼마입니까

SELECT ROUND (AVG (P.HEIGHT), 1)     평균키
  FROM PLAYER P JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
 WHERE     T.TEAM_ID LIKE
               (SELECT TEAM_ID
                  FROM TEAM
                 WHERE TEAM_NAME LIKE '시티즌')
       AND P.POSITION LIKE 'MF';

--020 2012년 월별 경기수를 구하시오

SELECT (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SCHE_DATE LIKE '201201%')
           "1월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SCHE_DATE LIKE '201202%')
           "2월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SCHE_DATE LIKE '201203%')
           "3월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SCHE_DATE LIKE '201204%')
           "4월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SCHE_DATE LIKE '201205%')
           "5월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SCHE_DATE LIKE '201206%')
           "6월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SCHE_DATE LIKE '201207%')
           "7월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SCHE_DATE LIKE '201208%')
           "8월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SCHE_DATE LIKE '201209%')
           "9월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SCHE_DATE LIKE '201210%')
           "10월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SCHE_DATE LIKE '201211%')
           "11월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SCHE_DATE LIKE '201212%')
           "12월"
  FROM DUAL;

--021 2012년 월별 진행된 경기수(GUBUN IS YES) 를 구하시오
--출력은 1월120경기 이런식으로

SELECT    '1월'
       || (SELECT COUNT (*)
             FROM SCHEDULE
            WHERE SCHE_DATE LIKE '201201%' AND GUBUN LIKE 'Y')
       || '경기'
           "1월",
          '2월'
       || (SELECT COUNT (*)
             FROM SCHEDULE
            WHERE SCHE_DATE LIKE '201202%' AND GUBUN LIKE 'Y')
       || '경기'
           "2월",
          '3월'
       || (SELECT COUNT (*)
             FROM SCHEDULE
            WHERE SCHE_DATE LIKE '201203%' AND GUBUN LIKE 'Y')
       || '경기'
           "3월",
          '4월'
       || (SELECT COUNT (*)
             FROM SCHEDULE
            WHERE SCHE_DATE LIKE '201204%' AND GUBUN LIKE 'Y')
       || '경기'
           "4월",
          '5월'
       || (SELECT COUNT (*)
             FROM SCHEDULE
            WHERE SCHE_DATE LIKE '201205%' AND GUBUN LIKE 'Y')
       || '경기'
           "5월",
          '6월'
       || (SELECT COUNT (*)
             FROM SCHEDULE
            WHERE SCHE_DATE LIKE '201206%' AND GUBUN LIKE 'Y')
       || '경기'
           "6월",
          '7월'
       || (SELECT COUNT (*)
             FROM SCHEDULE
            WHERE SCHE_DATE LIKE '201207%' AND GUBUN LIKE 'Y')
       || '경기'
           "7월",
          '8월'
       || (SELECT COUNT (*)
             FROM SCHEDULE
            WHERE SCHE_DATE LIKE '201208%' AND GUBUN LIKE 'Y')
       || '경기'
           "8월",
          '9월'
       || (SELECT COUNT (*)
             FROM SCHEDULE
            WHERE SCHE_DATE LIKE '201209%' AND GUBUN LIKE 'Y')
       || '경기'
           "9월",
          '10월'
       || (SELECT COUNT (*)
             FROM SCHEDULE
            WHERE SCHE_DATE LIKE '201210%' AND GUBUN LIKE 'Y')
       || '경기'
           "10월",
          '11월'
       || (SELECT COUNT (*)
             FROM SCHEDULE
            WHERE SCHE_DATE LIKE '201211%' AND GUBUN LIKE 'Y')
       || '경기'
           "11월",
          '12월'
       || (SELECT COUNT (*)
             FROM SCHEDULE
            WHERE SCHE_DATE LIKE '201212%' AND GUBUN LIKE 'Y')
       || '경기'
           "12월"
  FROM DUAL;


--022
--2012년 9월 14일에 벌어질 경기는 어디와 어디입니까
-- 홈팀:? 원정팀 :? 로 출력

SELECT '홈팀 : ' || HT.TEAM_NAME        홈팀,
       '원정팀 : ' || AT.TEAM_NAME     원정팀
  FROM SCHEDULE  SC
       JOIN TEAM HT ON SC.HOMETEAM_ID LIKE HT.TEAM_ID
       JOIN TEAM AT ON SC.AWAYTEAM_ID LIKE AT.TEAM_ID
 WHERE SCHE_DATE LIKE '20120914';

--023
--GROUP BY 사용
--팀별 선수의 수
--아이파크 20명
--드래곤즈 XX명

  SELECT T.TEAM_ID 팀ID, COUNT (P.PLAYER_ID) || '명' 선수인원
    FROM PLAYER P JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY T.TEAM_ID
ORDER BY T.TEAM_ID;

  SELECT (SELECT TEAM_NAME
            FROM TEAM
           WHERE TEAM_ID LIKE T.TEAM_ID)
             팀명,
         COUNT (P.PLAYER_ID) || '명'
             선수인원
    FROM PLAYER P JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY T.TEAM_ID
ORDER BY T.TEAM_ID;

  SELECT T.TEAM_NAME, COUNT (P.PLAYER_ID) || '명' 선수인원
    FROM PLAYER P JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY T.TEAM_NAME
ORDER BY T.TEAM_NAME;

--024
--팀별 골키퍼의 평균 키
--아이파크 180CM
--드래곤즈 178CM
--GROUP BY 는 기준칼럼을 반드시 SELECT에서 RETURN 되어야 한다.
--단, 스칼라를 이용해서 값을 변환할 수 있다.

  SELECT (SELECT TEAM_NAME
            FROM TEAM
           WHERE TEAM_ID LIKE T.TEAM_ID)
             팀명,
         ROUND (AVG (P.HEIGHT), 0) || 'cm'
             평균키
    FROM PLAYER P JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY T.TEAM_ID
ORDER BY T.TEAM_ID;

  SELECT T.TEAM_NAME 팀명, ROUND (AVG (P.HEIGHT)) || 'cm' 평균키
    FROM TEAM T JOIN PLAYER P ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY T.TEAM_NAME
ORDER BY T.TEAM_NAME;

-- CASE WHEN THEN 문 사용법 (자바의 SWITCH CASE 문 같은거)

SELECT PLAYER_NAME
           이름,
       CASE
           WHEN POSITION IS NULL THEN '없음'
           WHEN POSITION LIKE 'GK' THEN '골키퍼'
           WHEN POSITION LIKE 'DF' THEN '수비수'
           WHEN POSITION LIKE 'FW' THEN '공격수'
           WHEN POSITION LIKE 'MF' THEN '미드필더'
           ELSE POSITION
       END
           포지션
  FROM PLAYER
 WHERE TEAM_ID = 'K08';

-- ROWNUM 사용법
--025 키순서대로 정렬
--삼성블루윙즈에서 키순으로 11위부터 20위까지 출력
--2중 인라인뷰 사용

SELECT B.*
  FROM (SELECT ROWNUM "NO.", A.*
          FROM (  SELECT T.TEAM_NAME       팀명,
                         P.PLAYER_NAME     선수명,
                         P.POSITION        포지션,
                         P.BACK_NO         백넘버,
                         P.HEIGHT          키
                    FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
                   WHERE     T.TEAM_ID LIKE
                                 (SELECT TEAM_ID
                                    FROM TEAM
                                   WHERE TEAM_NAME LIKE '삼성블루윙즈')
                         AND P.HEIGHT IS NOT NULL
                ORDER BY P.HEIGHT DESC) A) B
 WHERE B."NO." BETWEEN 11 AND 20;

--026
--팀별 골키퍼의 평균 키를 구한 뒤
--평균키가 가장 큰 팀명은

SELECT B.TEAM_NAME     팀명
  FROM (SELECT ROWNUM RNUM, A.*
          FROM (  SELECT (SELECT TEAM_NAME
                            FROM TEAM
                           WHERE TEAM_ID LIKE T.TEAM_ID)
                             TEAM_NAME,
                         ROUND (AVG (P.HEIGHT), 1)
                             평균키
                    FROM TEAM T JOIN PLAYER P ON T.TEAM_ID LIKE P.TEAM_ID
                   WHERE P.HEIGHT IS NOT NULL AND P.POSITION LIKE 'GK'
                GROUP BY T.TEAM_ID
                ORDER BY 평균키 DESC) A) B
 WHERE B.RNUM = 1;

-- 027
-- 각 구단별 선수들 평균키가 삼성 블루윙즈팀의
-- 평균키보다 작은 팀의 이름과 해당 팀의 평균키를
-- 구하시오
SELECT 
        (SELECT TEAM_NAME
        FROM TEAM
        WHERE TEAM_ID LIKE T.TEAM_ID) TEAM_ID, ROUND(AVG(P.HEIGHT),1) 평균키
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY T.TEAM_ID
HAVING AVG(P.HEIGHT)<
    (SELECT AVG(P1.HEIGHT)
     FROM PLAYER P1
        JOIN TEAM T1
        ON P1.TEAM_ID LIKE T1.TEAM_ID
     WHERE T1.TEAM_NAME LIKE '삼성블루윙즈');
                      
                
-- 028
-- 2012년 경기 중에서 점수차가 가장 큰 경기 전부

SELECT B.SCHE_DATE                    경기일,
       B.WTEAM || 'VS' || B.LTEAM     홈팀VS원정팀,
       B.DSCORE || '점차경기'     점수차
  FROM (SELECT ROWNUM RNUM, A.*
          FROM (  SELECT SC.SCHE_DATE,
                         ABS (SC.HOME_SCORE - SC.AWAY_SCORE)     DSCORE,
                         HT.TEAM_NAME                            WTEAM,
                         AT.TEAM_NAME                            LTEAM
                    FROM SCHEDULE SC
                         JOIN TEAM HT ON HT.TEAM_ID LIKE SC.HOMETEAM_ID
                         JOIN TEAM AT ON AT.TEAM_ID LIKE SC.AWAYTEAM_ID
                   WHERE     SC.SCHE_DATE LIKE '2012%'
                         AND SC.HOME_SCORE IS NOT NULL
                ORDER BY DSCORE DESC) A) B
 WHERE B.RNUM =1;

SELECT A.*
FROM
    (SELECT SC.SCHE_DATE 경기날짜,
            HT.TEAM_NAME||'VS'||AT.TEAM_NAME 홈팀VS원정팀,
           CASE
            WHEN (SC.HOME_SCORE > SC.AWAY_SCORE) THEN (SC.HOME_SCORE - SC.AWAY_SCORE)
            ELSE (SC.AWAY_SCORE - SC.HOME_SCORE)
           END||'점수경기' 점수차
    FROM SCHEDULE SC
        JOIN TEAM HT
            ON HT.TEAM_ID LIKE SC.HOMETEAM_ID
        JOIN TEAM AT
            ON AT.TEAM_ID LIKE SC.AWAYTEAM_ID
    WHERE SC.SCHE_DATE LIKE '2012%'
        AND SC.GUBUN LIKE 'Y'
    ORDER BY 점수차 DESC) A
WHERE ROWNUM LIKE 1
;


-- 029
-- 좌석수대가 많은대로 스타디움 순서 매기기

SELECT ROWNUM "NO.", A.*
  FROM (SELECT STADIUM_NAME, SEAT_COUNT
        FROM STADIUM
        ORDER BY SEAT_COUNT DESC) A;

-- 030
-- 2012년 구단 승리 순으로 순위매기기
SELECT ROWNUM "순위", B.*
FROM
    (SELECT
        A.WINNER 승리팀,
        COUNT(A.WINNER) 승리수
    FROM
        (SELECT 
            CASE
                WHEN SC.HOME_SCORE > SC.AWAY_SCORE THEN HT.TEAM_NAME
                WHEN SC.AWAY_SCORE > SC.HOME_SCORE THEN AT.TEAM_NAME
                ELSE '무승부' 
            END WINNER
        FROM SCHEDULE SC
            JOIN TEAM HT
                ON HT.TEAM_ID LIKE SC.HOMETEAM_ID
            JOIN TEAM AT
                ON AT.TEAM_ID LIKE SC.AWAYTEAM_ID
        WHERE SC.SCHE_DATE LIKE '2012%') A
    WHERE A.WINNER NOT LIKE '무승부'
    GROUP BY A.WINNER
    ORDER BY 승리수 DESC) B
;
SELECT ROWNUM "순위", B.*
FROM
    (SELECT 
        A.WINNER,
        COUNT(A.WINNER) WIN
    FROM
        (SELECT 
            CASE 
                WHEN SC.HOME_SCORE > SC.AWAY_SCORE THEN HT.TEAM_NAME
                WHEN SC.AWAY_SCORE > SC.HOME_SCORE THEN AT.TEAM_NAME
                ELSE '무승부' 
            END WINNER
        FROM SCHEDULE SC
            JOIN TEAM HT
            ON HT.TEAM_ID LIKE SC.HOMETEAM_ID
            JOIN TEAM AT
            ON AT.TEAM_ID LIKE SC.AWAYTEAM_ID
        WHERE SC.SCHE_DATE LIKE '2012%') A
    WHERE A.WINNER NOT LIKE '무승부'
    GROUP BY A.WINNER
    ORDER BY WIN DESC) B
;
      