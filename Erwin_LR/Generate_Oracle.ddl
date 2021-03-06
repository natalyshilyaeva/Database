
CREATE TABLE Airline
(
	Name_Airline	  VARCHAR2(20)  NOT NULL ,
	Status		  INTEGER  NULL ,
	Foundation_date	  DATE  NULL ,
	Profit		  INTEGER  NULL 
);



CREATE UNIQUE INDEX XPKАвиакомпания ON Airline
(Name_Airline  ASC);



ALTER TABLE Airline
	ADD CONSTRAINT  XPKАвиакомпания PRIMARY KEY (Name_Airline);



CREATE UNIQUE INDEX XAK1Авиакомпания ON Airline
(Foundation_date  ASC);



CREATE TABLE Airport
(
	Name_airport	  VARCHAR2(20)  NOT NULL ,
	Status		  INTEGER  NULL ,
	Terminal	  INTEGER  NULL ,
	Line		  INTEGER  NULL ,
	City		  VARCHAR2(20)  NULL 
);



CREATE UNIQUE INDEX XPKАэропорт ON Airport
(Name_airport  ASC);



ALTER TABLE Airport
	ADD CONSTRAINT  XPKАэропорт PRIMARY KEY (Name_airport);



CREATE TABLE Flight
(
	Name_Airline	  VARCHAR2(20)  NOT NULL ,
	Name_airport	  VARCHAR2(20)  NOT NULL ,
	Name_plane	  VARCHAR2(20)  NOT NULL ,
	Number_flight	  INTEGER  NOT NULL ,
	Name_flight	  VARCHAR2(20)  NULL ,
	Departure_time	  DATE  NULL ,
	Time_in_put	  DATE  NULL ,
	From_where	  VARCHAR2(20)  NULL ,
	Where		  VARCHAR2(20)  NULL 
);



CREATE UNIQUE INDEX XPKРейс ON Flight
(Number_flight  ASC);



ALTER TABLE Flight
	ADD CONSTRAINT  XPKРейс PRIMARY KEY (Number_flight);



CREATE UNIQUE INDEX XAK1Рейс ON Flight
(From_where  ASC,Where  ASC);



CREATE INDEX XIE1Рейс ON Flight
(Time_in_put  ASC);



CREATE TABLE Plane
(
	Name_plane	  VARCHAR2(20)  NOT NULL ,
	Range_of_flight	  INTEGER  NULL ,
	Baggage		  INTEGER  NULL ,
	Capacity_of_people  INTEGER  NULL 
);



CREATE UNIQUE INDEX XPKСамолёт ON Plane
(Name_plane  ASC);



ALTER TABLE Plane
	ADD CONSTRAINT  XPKСамолёт PRIMARY KEY (Name_plane);



ALTER TABLE Flight
	ADD (CONSTRAINT  R_1 FOREIGN KEY (Name_Airline) REFERENCES Airline(Name_Airline));



ALTER TABLE Flight
	ADD (CONSTRAINT  R_4 FOREIGN KEY (Name_airport) REFERENCES Airport(Name_airport));



ALTER TABLE Flight
	ADD (CONSTRAINT  R_2 FOREIGN KEY (Name_plane) REFERENCES Plane(Name_plane));



ALTER TABLE Flight
	ADD (CONSTRAINT  R_3 FOREIGN KEY (Name_plane) REFERENCES Plane(Name_plane));



CREATE  TRIGGER tD_Airline AFTER DELETE ON Airline for each row
-- ERwin Builtin 27 сентября 2020 г. 3:42:55
-- DELETE trigger on Airline 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
    /* Airline R/1 Flight on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000dfc1", PARENT_OWNER="", PARENT_TABLE="Airline"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="Name_Airline" */
    SELECT count(*) INTO NUMROWS
      FROM Flight
      WHERE
        /*  %JoinFKPK(Flight,:%Old," = "," AND") */
        Flight.Name_Airline = :old.Name_Airline;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Airline because Flight exists.'
      );
    END IF;


-- ERwin Builtin 27 сентября 2020 г. 3:42:55
END;
/

CREATE  TRIGGER tU_Airline AFTER UPDATE ON Airline for each row
-- ERwin Builtin 27 сентября 2020 г. 3:42:55
-- UPDATE trigger on Airline 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
  /* Airline R/1 Flight on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00010a14", PARENT_OWNER="", PARENT_TABLE="Airline"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="Name_Airline" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    Airline.Name_Airline <> Airline.Name_Airline
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Flight
      WHERE
        /*  %JoinFKPK(Flight,:%Old," = "," AND") */
        Flight.Name_Airline = :old.Name_Airline;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Airline because Flight exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin 27 сентября 2020 г. 3:42:55
END;
/


CREATE  TRIGGER tD_Airport AFTER DELETE ON Airport for each row
-- ERwin Builtin 27 сентября 2020 г. 3:42:55
-- DELETE trigger on Airport 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
    /* Airport R/4 Flight on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000daa9", PARENT_OWNER="", PARENT_TABLE="Airport"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="Name_airport" */
    SELECT count(*) INTO NUMROWS
      FROM Flight
      WHERE
        /*  %JoinFKPK(Flight,:%Old," = "," AND") */
        Flight.Name_airport = :old.Name_airport;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Airport because Flight exists.'
      );
    END IF;


-- ERwin Builtin 27 сентября 2020 г. 3:42:55
END;
/

CREATE  TRIGGER tU_Airport AFTER UPDATE ON Airport for each row
-- ERwin Builtin 27 сентября 2020 г. 3:42:55
-- UPDATE trigger on Airport 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
  /* Airport R/4 Flight on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="000107f9", PARENT_OWNER="", PARENT_TABLE="Airport"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="Name_airport" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    Airport.Name_airport <> Airport.Name_airport
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Flight
      WHERE
        /*  %JoinFKPK(Flight,:%Old," = "," AND") */
        Flight.Name_airport = :old.Name_airport;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Airport because Flight exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin 27 сентября 2020 г. 3:42:55
END;
/


CREATE  TRIGGER tI_Flight BEFORE INSERT ON Flight for each row
-- ERwin Builtin 27 сентября 2020 г. 3:42:55
-- INSERT trigger on Flight 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
    /* Airline R/1 Flight on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0004124a", PARENT_OWNER="", PARENT_TABLE="Airline"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="Name_Airline" */
    SELECT count(*) INTO NUMROWS
      FROM Airline
      WHERE
        /* %JoinFKPK(:%New,Airline," = "," AND") */
        :new.Name_Airline = Airline.Name_Airline;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Flight because Airline does not exist.'
      );
    END IF;

    /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
    /* Plane R/2 Flight on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Plane"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="Name_plane" */
    SELECT count(*) INTO NUMROWS
      FROM Plane
      WHERE
        /* %JoinFKPK(:%New,Plane," = "," AND") */
        :new.Name_plane = Plane.Name_plane;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Flight because Plane does not exist.'
      );
    END IF;

    /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
    /* Plane R/3 Flight on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Plane"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="Name_plane" */
    SELECT count(*) INTO NUMROWS
      FROM Plane
      WHERE
        /* %JoinFKPK(:%New,Plane," = "," AND") */
        :new.Name_plane = Plane.Name_plane;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Flight because Plane does not exist.'
      );
    END IF;

    /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
    /* Airport R/4 Flight on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Airport"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="Name_airport" */
    SELECT count(*) INTO NUMROWS
      FROM Airport
      WHERE
        /* %JoinFKPK(:%New,Airport," = "," AND") */
        :new.Name_airport = Airport.Name_airport;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Flight because Airport does not exist.'
      );
    END IF;


-- ERwin Builtin 27 сентября 2020 г. 3:42:55
END;
/

CREATE  TRIGGER tU_Flight AFTER UPDATE ON Flight for each row
-- ERwin Builtin 27 сентября 2020 г. 3:42:55
-- UPDATE trigger on Flight 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
  /* Airline R/1 Flight on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00040325", PARENT_OWNER="", PARENT_TABLE="Airline"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="Name_Airline" */
  SELECT count(*) INTO NUMROWS
    FROM Airline
    WHERE
      /* %JoinFKPK(:%New,Airline," = "," AND") */
      :new.Name_Airline = Airline.Name_Airline;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Flight because Airline does not exist.'
    );
  END IF;

  /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
  /* Plane R/2 Flight on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Plane"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="Name_plane" */
  SELECT count(*) INTO NUMROWS
    FROM Plane
    WHERE
      /* %JoinFKPK(:%New,Plane," = "," AND") */
      :new.Name_plane = Plane.Name_plane;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Flight because Plane does not exist.'
    );
  END IF;

  /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
  /* Plane R/3 Flight on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Plane"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="Name_plane" */
  SELECT count(*) INTO NUMROWS
    FROM Plane
    WHERE
      /* %JoinFKPK(:%New,Plane," = "," AND") */
      :new.Name_plane = Plane.Name_plane;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Flight because Plane does not exist.'
    );
  END IF;

  /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
  /* Airport R/4 Flight on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Airport"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="Name_airport" */
  SELECT count(*) INTO NUMROWS
    FROM Airport
    WHERE
      /* %JoinFKPK(:%New,Airport," = "," AND") */
      :new.Name_airport = Airport.Name_airport;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Flight because Airport does not exist.'
    );
  END IF;


-- ERwin Builtin 27 сентября 2020 г. 3:42:55
END;
/


CREATE  TRIGGER tD_Plane AFTER DELETE ON Plane for each row
-- ERwin Builtin 27 сентября 2020 г. 3:42:55
-- DELETE trigger on Plane 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
    /* Plane R/2 Flight on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0001c204", PARENT_OWNER="", PARENT_TABLE="Plane"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="Name_plane" */
    SELECT count(*) INTO NUMROWS
      FROM Flight
      WHERE
        /*  %JoinFKPK(Flight,:%Old," = "," AND") */
        Flight.Name_plane = :old.Name_plane;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Plane because Flight exists.'
      );
    END IF;

    /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
    /* Plane R/3 Flight on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Plane"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="Name_plane" */
    SELECT count(*) INTO NUMROWS
      FROM Flight
      WHERE
        /*  %JoinFKPK(Flight,:%Old," = "," AND") */
        Flight.Name_plane = :old.Name_plane;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Plane because Flight exists.'
      );
    END IF;


-- ERwin Builtin 27 сентября 2020 г. 3:42:55
END;
/

CREATE  TRIGGER tU_Plane AFTER UPDATE ON Plane for each row
-- ERwin Builtin 27 сентября 2020 г. 3:42:55
-- UPDATE trigger on Plane 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
  /* Plane R/2 Flight on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="000212cb", PARENT_OWNER="", PARENT_TABLE="Plane"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="Name_plane" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    Plane.Name_plane <> Plane.Name_plane
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Flight
      WHERE
        /*  %JoinFKPK(Flight,:%Old," = "," AND") */
        Flight.Name_plane = :old.Name_plane;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Plane because Flight exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin 27 сентября 2020 г. 3:42:55 */
  /* Plane R/3 Flight on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Plane"
    CHILD_OWNER="", CHILD_TABLE="Flight"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="Name_plane" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    Plane.Name_plane <> Plane.Name_plane
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Flight
      WHERE
        /*  %JoinFKPK(Flight,:%Old," = "," AND") */
        Flight.Name_plane = :old.Name_plane;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Plane because Flight exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin 27 сентября 2020 г. 3:42:55
END;
/

