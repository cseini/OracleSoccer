-- SOCCER_SQL_001
SELECT 
    COUNT(*) "���̺��� ��" 
FROM TAB;
-- SOCCER_SQL_002
SELECT 
    TEAM_NAME "��ü �౸�� ���" 
FROM TEAM
ORDER BY TEAM_NAME DESC
;
-- SOCCER_SQL_003
-- ������ ����(�ߺ�����,������ �������� ����)
-- NVL2()
SELECT DISTINCT NVL2(POSITION,POSITION,'����') "������" 
FROM PLAYER;
-- SOCCER_SQL_004
-- ������(ID: K02)��Ű��
SELECT PLAYER_NAME �̸�
FROM PLAYER
WHERE TEAM_ID = 'K02'
    AND POSITION = 'GK'
ORDER BY PLAYER_NAME 
;
-- SOCCER_SQL_005
-- ������(ID: K02)Ű�� 170 �̻� ����
-- �̸鼭 ���� ���� ����
SELECT POSITION ������,PLAYER_NAME �̸�
FROM PLAYER
WHERE HEIGHT >= 170
    AND TEAM_ID LIKE 'K02'
    AND SUBSTR(PLAYER_NAME,0,1) LIKE '��'
ORDER BY PLAYER_NAME 
;
-- SUBSTR('ȫ�浿',2,2) �ϸ�
-- �浿�� ��µǴµ�
-- ��2�� ������ġ, ��2�� ���ڼ��� ����
SELECT SUBSTR(PLAYER_NAME,2,2) �׽�Ʈ��
FROM PLAYER
;
-- �ٸ� Ǯ��(����)
SELECT POSITION ������,PLAYER_NAME �̸�
FROM PLAYER
WHERE HEIGHT >= 170
    AND TEAM_ID LIKE 'K02'
    AND PLAYER_NAME LIKE '��%'
ORDER BY PLAYER_NAME 
;
-- SOCCER_SQL_006
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� CM �� KG ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- Ű ��������
SELECT 
    PLAYER_NAME || '����' �̸�,
    NVL2(HEIGHT,HEIGHT,0) || 'CM' Ű,
    NVL2(WEIGHT,WEIGHT,0) || 'KG' ������
FROM PLAYER
WHERE TEAM_ID LIKE 'K02'
ORDER BY HEIGHT DESC
;
-- SOCCER_SQL_007
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� CM �� KG ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- BMI���� 
-- Ű ��������
SELECT 
    PLAYER_NAME || '����' �̸�,
    NVL2(HEIGHT,HEIGHT,0) || 'CM' Ű,
    NVL2(WEIGHT,WEIGHT,0) || 'KG' ������,
    ROUND(WEIGHT/((HEIGHT/100)*(HEIGHT/100)),2) "BMI ������"
FROM PLAYER
WHERE TEAM_ID = 'K02'
ORDER BY HEIGHT DESC
;
-- SOCCER_SQL_008
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- GK �������� ����
-- ����, ����� ��������
SELECT 
    T.TEAM_NAME,
    P.POSITION,
    P.PLAYER_NAME 
FROM PLAYER P, TEAM T
WHERE T.TEAM_ID = P.TEAM_ID
    AND T.TEAM_ID IN ( 'K02', 'K10')
    AND P.POSITION LIKE 'GK'
ORDER BY T.TEAM_NAME, P.PLAYER_NAME
;
-- ANSI JOIN ���(����)
SELECT 
    T.TEAM_NAME,
    P.POSITION,
    P.PLAYER_NAME 
FROM PLAYER P
INNER JOIN TEAM T
ON T.TEAM_ID LIKE P.TEAM_ID
WHERE T.TEAM_ID IN ( 'K02', 'K10')
    AND P.POSITION LIKE 'GK'
ORDER BY T.TEAM_NAME, P.PLAYER_NAME
;
-- SOCCER_SQL_009
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- Ű�� 180 �̻� 183 ������ ������
-- Ű, ����, ����� ��������
SELECT 
    P.HEIGHT || 'CM' Ű,
    T.TEAM_NAME ����,
    P.PLAYER_NAME �̸�
FROM PLAYER P, TEAM T
WHERE 
    T.TEAM_ID = P.TEAM_ID
    AND T.TEAM_ID IN ( 'K02', 'K10')
    AND P.HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT, T.TEAM_NAME, P.PLAYER_NAME
;
-- ANSI JOIN ���(����)
SELECT P.HEIGHT ||'CM' Ű,
    T.TEAM_NAME ����, 
    P.PLAYER_NAME �̸�
FROM PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE T.TEAM_ID IN ('K02', 'K10')
    AND P.HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT, T.TEAM_NAME, P.PLAYER_NAME
; 
-- SOCCER_SQL_010
--  ��� ������ ��
-- �������� �������� ���� �������� ���� �̸�
-- ����, ����� ��������
SELECT 
    T.TEAM_NAME,
    P.PLAYER_NAME 
FROM PLAYER P, TEAM T
WHERE  P.POSITION IS NULL
ORDER BY T.TEAM_NAME, P.PLAYER_NAME
;
-- SOCCER_SQL_011
-- ���̸�, ��Ÿ��� �̸� ���
SELECT T.TEAM_NAME ����,S.STADIUM_NAME ��Ÿ���
FROM STADIUM S 
    JOIN TEAM T
    ON T.STADIUM_ID LIKE S.STADIUM_ID
ORDER BY T.TEAM_NAME     
;
-- SOCCER_SQL_012
-- 2012�� 3�� 17�Ͽ� ���� �� ����� 
-- ���̸�, ��Ÿ���, ������� �̸� ���



-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�
SELECT 
    P.PLAYER_NAME ������,
    P.POSITION ������,
    T.REGION_NAME || '  '||T.TEAM_NAME ����,
    S.STADIUM_NAME ��Ÿ���,
    K.SCHE_DATE �����ٳ�¥
FROM 
    TEAM T    
    JOIN STADIUM S
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN PLAYER P     
        ON T.TEAM_ID LIKE P.TEAM_ID
    JOIN SCHEDULE K
        ON S.STADIUM_ID LIKE K.STADIUM_ID
WHERE
    K.SCHE_DATE LIKE '20120317'    
    AND P.POSITION LIKE 'GK'
    AND S.STADIUM_NAME LIKE '���׽�ƿ�ߵ�'
ORDER BY P.PLAYER_NAME     
; 
-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�
SELECT 
    S.STADIUM_NAME ��Ÿ���,
    K.SCHE_DATE ��⳯¥,
    HT.REGION_NAME || '  '||HT.TEAM_NAME Ȩ��,
    AT.REGION_NAME || '  '||AT.TEAM_NAME ������,
    K.HOME_SCORE "Ȩ�� ����",
    K.AWAY_SCORE "������ ����"
FROM 
    SCHEDULE K    
    JOIN STADIUM S
        ON K.STADIUM_ID LIKE S.STADIUM_ID
    JOIN TEAM HT     
        ON K.HOMETEAM_ID LIKE HT.TEAM_ID
    JOIN TEAM AT
        ON K.AWAYTEAM_ID LIKE AT.TEAM_ID
WHERE
    K.HOME_SCORE >= K.AWAY_SCORE +3 
ORDER BY K.SCHE_DATE     
;
-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
SELECT 
    S.STADIUM_NAME,
    S.STADIUM_ID,
    S.SEAT_COUNT,
    S.HOMETEAM_ID,
    T.E_TEAM_NAME
FROM STADIUM S
    LEFT JOIN TEAM T
        ON S.HOMETEAM_ID LIKE T.TEAM_ID
ORDER BY S.HOMETEAM_ID
;
-- SOCCER_SQL_016
-- �Ҽ��� �Ｚ ������� ���� �������
-- ���� �巡�������� �������� ���� ����
---- UNION VERSION
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
    T.TEAM_ID LIKE 'K02'
UNION
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
    T.TEAM_ID LIKE 'K07'
;
---- OR VERSION
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
    T.TEAM_ID LIKE 'K02' 
    OR T.TEAM_ID LIKE 'K07'
;
---- IN VERSION
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
    T.TEAM_ID IN ('K02', 'K07')
;

-- SOCCER_SQL_017
-- �Ҽ��� �Ｚ ������� ���� �������
-- ���� �巡�������� �������� ���� ����
---- SUBQUERY VERSION
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

-- 018
-- ��ȣ�� ������ �Ҽ����� ������, ��ѹ��� �����Դϱ�
SELECT T.TEAM_NAME ����, P.POSITION ������, P.BACK_NO ��ѹ�
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID
WHERE P.PLAYER_NAME LIKE '��ȣ��'
;

--019 ������Ƽ���� MF ���Ű�� ���Դϱ�
SELECT round(avg(P.HEIGHT),1) ���Ű
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID
WHERE T.TEAM_ID LIKE (SELECT TEAM_ID
                      FROM TEAM
                      WHERE TEAM_NAME LIKE '��Ƽ��')
    AND P.POSITION LIKE 'MF'
;

--020 2012�� ���� ������ ���Ͻÿ�
SELECT (SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201201%') "1��",
        (SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201202%') "2��",
        (SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201203%') "3��",
        (SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201204%') "4��",
        (SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201205%') "5��",
        (SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201206%') "6��",
        (SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201207%') "7��",
        (SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201208%') "8��",
        (SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201209%') "9��",
        (SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201210%') "10��",
        (SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201211%') "11��",
        (SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201212%') "12��"
FROM DUAL
;

--021 2012�� ���� ����� ����(GUBUN IS YES) �� ���Ͻÿ�
--����� 1��120��� �̷�������
SELECT '1��'||(SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201201%'
        AND GUBUN LIKE 'Y')||'���' "1��",
        '2��'||(SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201202%'
        AND GUBUN LIKE 'Y')||'���' "2��",
        '3��'||(SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201203%'
        AND GUBUN LIKE 'Y')||'���' "3��",
        '4��'||(SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201204%'
        AND GUBUN LIKE 'Y')||'���' "4��",
        '5��'||(SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201205%'
        AND GUBUN LIKE 'Y')||'���' "5��",
        '6��'||(SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201206%'
        AND GUBUN LIKE 'Y')||'���' "6��",
        '7��'||(SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201207%'
        AND GUBUN LIKE 'Y')||'���' "7��",
        '8��'||(SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201208%'
        AND GUBUN LIKE 'Y')||'���' "8��",
        '9��'||(SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201209%'
        AND GUBUN LIKE 'Y')||'���' "9��",
        '10��'||(SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201210%'
        AND GUBUN LIKE 'Y')||'���' "10��",
        '11��'||(SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201211%'
        AND GUBUN LIKE 'Y')||'���' "11��",
        '12��'||(SELECT COUNT(*)
        FROM SCHEDULE
        WHERE SCHE_DATE LIKE '201212%'
        AND GUBUN LIKE 'Y')||'���' "12��"
FROM DUAL
;


--022
--2012�� 9�� 14�Ͽ� ������ ���� ���� ����Դϱ�
-- Ȩ��:? ������ :? �� ���

SELECT 'Ȩ�� : '||HT.TEAM_NAME Ȩ��, '������ : '||AT.TEAM_NAME ������
FROM SCHEDULE SC
    JOIN TEAM HT
    ON SC.HOMETEAM_ID LIKE HT.TEAM_ID
    JOIN TEAM AT
    ON SC.AWAYTEAM_ID LIKE AT.TEAM_ID 
WHERE SCHE_DATE LIKE '20120914'
;

--023
--GROUP BY ���
--���� ������ ��
--������ũ 20��
--�巡���� XX��
SELECT
    T.TEAM_ID ��ID,
    COUNT(P.PLAYER_ID)||'��' �����ο�
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID 
GROUP BY T.TEAM_ID
ORDER BY T.TEAM_ID;

SELECT
    (SELECT TEAM_NAME
     FROM TEAM
     WHERE TEAM_ID LIKE T.TEAM_ID) ����,
    COUNT(P.PLAYER_ID)||'��' �����ο�
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID 
GROUP BY T.TEAM_ID
ORDER BY T.TEAM_ID;

SELECT
    T.TEAM_NAME,
    COUNT(P.PLAYER_ID)||'��' �����ο�
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID 
GROUP BY T.TEAM_NAME
ORDER BY T.TEAM_NAME;

--024
--���� ��Ű���� ��� Ű
--������ũ 180CM
--�巡���� 178CM
--GROUP BY �� ����Į���� �ݵ�� SELECT���� RETURN �Ǿ�� �Ѵ�.
--��, ��Į�� �̿��ؼ� ���� ��ȯ�� �� �ִ�.
SELECT (SELECT TEAM_NAME
        FROM TEAM
        WHERE TEAM_ID LIKE T.TEAM_ID) ����,
        ROUND(AVG(P.HEIGHT),0)||'cm' ���Ű
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY T.TEAM_ID
ORDER BY T.TEAM_ID
;

SELECT T.TEAM_NAME ����, ROUND(AVG(P.HEIGHT))||'cm' ���Ű
FROM TEAM T
    JOIN PLAYER P
    ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY T.TEAM_NAME
ORDER BY T.TEAM_NAME;

-- CASE WHEN THEN �� ���� (�ڹ��� SWITCH CASE �� ������)
SELECT 
    PLAYER_NAME �̸�,
    CASE
        WHEN POSITION IS NULL THEN '����'
        WHEN POSITION LIKE 'GK' THEN '��Ű��'
        WHEN POSITION LIKE 'DF' THEN '�����'
        WHEN POSITION LIKE 'FW' THEN '���ݼ�'
        WHEN POSITION LIKE 'MF' THEN '�̵��ʴ�'
        ELSE POSITION
    END ������
FROM
    PLAYER
WHERE
    TEAM_ID = 'K08'
;



