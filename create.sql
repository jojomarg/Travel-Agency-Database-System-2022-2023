Create database hospital;
use hospital;

CREATE TABLE doctor(
  doctor_id INT(9) NOT NULL AUTO_INCREMENT,
  doctor_name VARCHAR(25) DEFAULT 'unknown' NOT NULL,
  doctor_lastname VARCHAR(25) DEFAULT 'unknown' NOT NULL,
  gender ENUM('Male' , 'Female'),
  identification_number VARCHAR(8) NOT NULL,
  street VARCHAR(25) DEFAULT 'unknown' NOT NULL,
  number INT UNSIGNED DEFAULT '0' NOT NULL,
  city VARCHAR(25) DEFAULT 'unknown' NOT NULL,
  postal_code MEDIUMINT(128)  DEFAULT '0' NOT NULL,
  office_number INT DEFAULT '0' NOT NULL,
  PRIMARY KEY(doctor_id)
) engine=InnoDB;

CREATE TABLE clinic(
  clinic_name VARCHAR(25) NOT NULL,
  number_of_rooms MEDIUMINT(128) DEFAULT '0' NOT NULL,
  building ENUM ('A', 'B', 'C', 'D', 'E') NOT NULL,
  level   ENUM ('1','2','3','4','5') NOT NULL,
  manager INT(9),
  manager_start_date DATE NOT NULL,
  manager_end_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY(clinic_name),
  CONSTRAINT CLCMANAGEMENT FOREIGN KEY (manager) REFERENCES doctor(doctor_id) 
  ON UPDATE CASCADE ON DELETE CASCADE
) engine=InnoDB;

CREATE TABLE patient(
  patient_id INT(9) NOT NULL AUTO_INCREMENT,
  patient_name VARCHAR(25)  DEFAULT 'unknown' NOT NULL,
  patient_lastname VARCHAR(25)  DEFAULT 'unknown' NOT NULL,
  patient_gender ENUM('Male', 'Female') NOT NUll,
  patient_identification_number VARCHAR(20) NOT NULL,
  patient_street VARCHAR(25) DEFAULT 'unknown' NOT NULL,
  patient_number INT UNSIGNED DEFAULT '0' NOT NULL,
  patient_city VARCHAR(25) DEFAULT 'unknown' NOT NULL,
  patient_postal_code MEDIUMINT(128)  DEFAULT '0' NOT NULL,
  treatment_clinic_name VARCHAR(25) NOT NULL,
  PRIMARY KEY(patient_id),
  CONSTRAINT CARECLINIC FOREIGN KEY (treatment_clinic_name) REFERENCES clinic(clinic_name)
  ON UPDATE CASCADE ON DELETE CASCADE
) engine=InnoDB;

CREATE TABLE nurse(
  nurse_id INT(9) NOT NULL AUTO_INCREMENT,
  nurse_name VARCHAR(25)  DEFAULT 'unknown' NOT NULL,
  nurse_lastname VARCHAR(25)  DEFAULT 'unknown' NOT NULL,
  nurse_gender ENUM('Male', 'Female') NOT NUll,
  nurse_identification_number VARCHAR(8) NOT NULL,
  nurse_street VARCHAR(25) DEFAULT 'unknown' NOT NULL,
  nurse_number INT UNSIGNED DEFAULT '0' NOT NULL,
  nurse_city VARCHAR(25) DEFAULT 'unknown' NOT NULL,
  nurse_postal_code MEDIUMINT(128)  DEFAULT '0' NOT NULL,
  nurse_tel VARCHAR(10) NOT NULL,
  PRIMARY KEY(nurse_id)
) engine=InnoDB;

CREATE TABLE diploma(
  doctor_id INT(9) NOT NULL,
  title VARCHAR(255) NOT NULL,
  date DATE NOT NULL,  
  specialty SET('Pathologos','Xeirourgos','Pneumonologos','Nevrologos','Kardiologos'),
  CONSTRAINT DOCDIPLOMA FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
  ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB;

CREATE TABLE treatment(
  patient INT(9) NOT NULL,
  doctor INT(9) NOT NULL,
  PRIMARY KEY(patient,doctor),
  CONSTRAINT PATIENTTREADED FOREIGN KEY (patient) REFERENCES patient(patient_id)
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT DOCTORTREATS FOREIGN KEY (doctor) REFERENCES doctor(doctor_id)
  ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB;

CREATE TABLE doctor_works(
  doctor INT(9) NOT NULL,
  clinic VARCHAR(25) NOT NULL,
  PRIMARY KEY(doctor,clinic),
  CONSTRAINT DOCTORWORK FOREIGN KEY(doctor) REFERENCES doctor(doctor_id)
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT CLINICWRK FOREIGN KEY(clinic) REFERENCES clinic(clinic_name)
  ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB;

CREATE TABLE nurse_works(
  nurse INT(9) NOT NULL,
  clinic VARCHAR(25) NOT NULL,
  PRIMARY KEY(nurse,clinic),
  CONSTRAINT NURSEWORK FOREIGN KEY(nurse) REFERENCES nurse(nurse_id) 
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT CLINICNURSEWRK FOREIGN KEY(clinic) REFERENCES clinic(clinic_name)
  ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB;

CREATE TABLE telephones(
  phone_number  VARCHAR(10) NOT NULL,
  doctor INT(9) NOT NULL,
  PRIMARY KEY (phone_number, doctor),
  CONSTRAINT DOCTORPHONES
  FOREIGN KEY(doctor) REFERENCES doctor(doctor_id)
  ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB;

CREATE TABLE drugs(
  name VARCHAR(255) NOT NULL,
  patient INT(9) NOT NULL,
  PRIMARY KEY(name,patient),
  CONSTRAINT DRGPATIENT
  FOREIGN KEY(patient) REFERENCES patient(patient_id)
  ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB;

