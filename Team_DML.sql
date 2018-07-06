-- �п� �л��� ���̺�
SELECT * from TAB;
SELECT * from MEMBER;
ALTER TABLE MEMBER RENAME COLUMN MEM_AGE TO AGE;

CREATE TABLE TEAMZ(
    TEAM_ID VARCHAR2(20) PRIMARY KEY,
    TEAM_NAME VARCHAR(20)
);
ALTER TABLE TEAMZ
RENAME TO PROJECT_TEAM;

CREATE TABLE TEAMW(
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    TEAM_ID VARCHAR2(20),
    MEM_NAME NVARCHAR2(20),
    MEM_AGE DECIMAL,
    ROLL VARCHAR2(20)
);  

ALTER TABLE TEAMW
RENAME TO MEMBER;

INSERT INTO TEAMZ(
    TEAM_ID, TEAM_NAME
)
    VALUES(
    'ATEAM', '����Ƽ��'
);
INSERT INTO TEAMZ(
    TEAM_ID, TEAM_NAME
)
    VALUES(
    'HTEAM', '��ī��' 
);
INSERT INTO TEAMZ(
    TEAM_ID, TEAM_NAME
)
    VALUES(
    'CTEAM', '������'
);
INSERT INTO TEAMZ(
    TEAM_ID, TEAM_NAME
)
    VALUES(
    'STEAM', '�����' 
);

INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'A1','ATEAM','����',34
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'A2','ATEAM','����',35
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'A3','ATEAM','����',21
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'A4','ATEAM','����',29
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'A5','ATEAM','����',25
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'H6','HTEAM','����',26
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'H7','HTEAM','����',26
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'H8','HTEAM','��',27
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'H9','HTEAM','���',30
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'H10','HTEAM','�ܾ�',26
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'C11','CTEAM','������',32
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'C12','CTEAM','��ȣ',31
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'C13','CTEAM','����',29
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'C14','CTEAM','����',23
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'C15','CTEAM','����',30
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'S16','STEAM','��ȣ',27
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'S17','STEAM','����',26
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'S18','STEAM','�̽�',29
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'S19','STEAM','����',26
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID,MEM_NAME, MEM_AGE
)VALUES
(
    'S20','STEAM','����',30
);

--���� ������
SELECT TZ.TEAM_NAME ��, COUNT(*) ������ 
FROM TEAMZ TZ
    JOIN TEAMW TW
    ON TZ.TEAM_ID LIKE TW.TEAM_ID
GROUP BY TZ.TEAM_NAME
ORDER BY TZ.TEAM_NAME;

SELECT (SELECT TEAM_NAME 
        FROM TEAMZ
        WHERE TEAM_ID LIKE TZ.TEAM_ID) ����
        , COUNT(*) ������ 
FROM TEAMZ TZ
    JOIN TEAMW TW
    ON TZ.TEAM_ID LIKE TW.TEAM_ID
GROUP BY TZ.TEAM_ID
ORDER BY TZ.TEAM_ID;

--SUM()���� ������
SELECT (SELECT TEAM_NAME 
        FROM TEAMZ
        WHERE TEAM_ID LIKE TZ.TEAM_ID) ����, SUM(TW.MEM_AGE) "������"
FROM TEAMZ TZ
    JOIN TEAMW TW
    ON TZ.TEAM_ID LIKE TW.TEAM_ID
GROUP BY TZ.TEAM_ID
;

--MAX()���� �����ִ�ġ
SELECT (SELECT TEAM_NAME 
        FROM TEAMZ
        WHERE TEAM_ID LIKE TZ.TEAM_ID) ����, MAX(TW.MEM_AGE) "�����ִ�"
FROM TEAMZ TZ
    JOIN TEAMW TW
    ON TZ.TEAM_ID LIKE TW.TEAM_ID
GROUP BY TZ.TEAM_ID;

--MIN()���������ּ�ġ
SELECT (SELECT TEAM_NAME 
        FROM TEAMZ
        WHERE TEAM_ID LIKE TZ.TEAM_ID) ����, MIN(TW.MEM_AGE) "�����ּ�"
FROM TEAMZ TZ
    JOIN TEAMW TW
    ON TZ.TEAM_ID LIKE TW.TEAM_ID
GROUP BY TZ.TEAM_ID;

--AVG()���� �������
SELECT (SELECT TEAM_NAME 
        FROM TEAMZ
        WHERE TEAM_ID LIKE TZ.TEAM_ID) ����, AVG(TW.MEM_AGE) "�������"
FROM TEAMZ TZ
    JOIN TEAMW TW
    ON TZ.TEAM_ID LIKE TW.TEAM_ID
GROUP BY TZ.TEAM_ID;

-- �� ���ļ�
SELECT (SELECT TEAM_NAME 
        FROM TEAMZ
        WHERE TEAM_ID LIKE TZ.TEAM_ID) ����,
        COUNT(*) ������,
        SUM(TW.MEM_AGE) "������",
        MAX(TW.MEM_AGE) "�����ִ�",
        MIN(TW.MEM_AGE) "�����ּ�",
        AVG(TW.MEM_AGE) "�������"
FROM TEAMZ TZ
    JOIN TEAMW TW
        ON TZ.TEAM_ID LIKE TW.TEAM_ID
GROUP BY TZ.TEAM_ID

ORDER BY TZ.TEAM_ID;

--����Ű ��������
ALTER TABLE TEAMW ADD CONSTRAINT TEAM_fk_TEAM_ID
FOREIGN KEY (TEAM_ID) REFERENCES TEAMZ(TEAM_ID);

-- ����Ű �������� ����
ALTER TABLE TEAMW DROP CONSTRAINT team_fk_team_id;

SELECT Z.TEAM_ID ��ID,
    Z.TEAM_NAME �̸�,
    CASE
        WHEN W.ROLL LIKE '����' THEN '����'
    END ����
FROM TEAMW W
    JOIN TEAMZ Z
        ON W.TEAM_ID LIKE Z.TEAM_ID;
        
UPDATE TEAMW
SET ROLL =
    CASE
         WHEN MEM_NAME IN ('����','����','������','��ȣ') THEN '����'
         ELSE '����'
    END;    
SELECT * FROM TEAMW;
SELECT * FROM TEAMZ;

--COLUMN ����
ALTER TABLE TEAMW DROP COLUMN ROLL;
--COLUMN �߰�
ALTER TABLE TEAMW ADD (ROLL VARCHAR2(20));

CREATE TABLE EXAM(
    EXAM_SEQ DECIMAL PRIMARY KEY,
    MEM_ID VARCHAR2(20),
    SUB_SEQ DECIMAL,
    SCORE VARCHAR2(20),
    MONTH VARCHAR2(20),
    RECORD_SEQ DECIMAL
);
CREATE TABLE RECORD(
    RECORD_SEQ DECIMAL PRIMARY KEY,
    GRADE VARCHAR2(20),
    AVG VARCHAR2(20)
);
CREATE TABLE SUBJECT(
    SUB_SEQ DECIMAL PRIMARY KEY,
    SUB_NAME VARCHAR2(20)
);
ALTER TABLE exam ADD CONSTRAINT member_fk_mem_id
    FOREIGN KEY (mem_id) REFERENCES member(mem_id);

ALTER TABLE exam ADD CONSTRAINT record_fk_record_seq
    FOREIGN KEY (record_seq) REFERENCES record(record_seq);

ALTER TABLE exam ADD CONSTRAINT subject_fk_sub_seq
    FOREIGN KEY (sub_seq) REFERENCES subject(sub_seq);
        
DESC SUBJECT;
CREATE SEQUENCE sub_seq
start with 1
increment BY 1;
drop sequence sub_seq;

INSERT INTO SUBJECT (
    SUB_SEQ,
    SUB_NAME
)
VALUES
(
    SUB_SEQ.NEXTVAL,
    'JAVA'
);
INSERT INTO SUBJECT (
    SUB_SEQ,
    SUB_NAME
)
VALUES
(
    SUB_SEQ.NEXTVAL,
    'SQL'
);
INSERT INTO SUBJECT (
    SUB_SEQ,
    SUB_NAME
)
VALUES
(
    SUB_SEQ.NEXTVAL,
    'HTML5'
);
INSERT INTO SUBJECT (
    SUB_SEQ,
    SUB_NAME
)
VALUES
(
    SUB_SEQ.NEXTVAL,
    'R'
);
INSERT INTO SUBJECT (
    SUB_SEQ,
    SUB_NAME
)
VALUES
(
    SUB_SEQ.NEXTVAL,
    'PYTHON'
);
drop table subject;
desc subject;
delete from subject
where sub_seq >20; 

SELECT * from SUBJECT;
SELECT * from EXAM;
SELECT * from RECORD;
SELECT * from MEMBER;
SELECT * from PROJECT_TEAM;
SELECT * from TAB;
