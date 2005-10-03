DROP TABLE IF EXISTS branches;
CREATE TABLE branches (
  id mediumint(9) NOT NULL auto_increment,
  branch varchar(64) binary DEFAULT '' NOT NULL,
  PRIMARY KEY (id),
  UNIQUE branch (branch)
);

DROP TABLE IF EXISTS checkins;
CREATE TABLE checkins (
  type enum('Change','Add','Remove'),
  ci_when datetime DEFAULT '0000-00-00 00:00:00' NOT NULL,
  whoid mediumint(9) DEFAULT '0' NOT NULL,
  repositoryid mediumint(9) DEFAULT '0' NOT NULL,
  dirid mediumint(9) DEFAULT '0' NOT NULL,
  fileid mediumint(9) DEFAULT '0' NOT NULL,
  revision varchar(32) binary DEFAULT '' NOT NULL,
  stickytag varchar(255) binary DEFAULT '' NOT NULL,
  branchid mediumint(9) DEFAULT '0' NOT NULL,
  addedlines int(11) DEFAULT '0' NOT NULL,
  removedlines int(11) DEFAULT '0' NOT NULL,
  descid mediumint(9),
  UNIQUE repositoryid (repositoryid,dirid,fileid,revision),
  KEY ci_when (ci_when),
  KEY whoid (whoid),
  KEY repositoryid_2 (repositoryid),
  KEY dirid (dirid),
  KEY fileid (fileid),
  KEY branchid (branchid)
);

DROP TABLE IF EXISTS descs;
CREATE TABLE descs (
  id mediumint(9) NOT NULL auto_increment,
  description text,
  hash bigint(20) DEFAULT '0' NOT NULL,
  PRIMARY KEY (id),
  KEY hash (hash)
);

DROP TABLE IF EXISTS dirs;
CREATE TABLE dirs (
  id mediumint(9) NOT NULL auto_increment,
  dir varchar(255) binary DEFAULT '' NOT NULL,
  PRIMARY KEY (id),
  UNIQUE dir (dir)
);
DROP TABLE IF EXISTS files;
CREATE TABLE files (
  id mediumint(9) NOT NULL auto_increment,
  file varchar(255) binary DEFAULT '' NOT NULL,
  PRIMARY KEY (id),
  UNIQUE file (file)
);

DROP TABLE IF EXISTS people;
CREATE TABLE people (
  id mediumint(9) NOT NULL auto_increment,
  who varchar(32) binary DEFAULT '' NOT NULL,
  PRIMARY KEY (id),
  UNIQUE who (who)
);

DROP TABLE IF EXISTS repositories;
CREATE TABLE repositories (
  id mediumint(9) NOT NULL auto_increment,
  repository varchar(64) binary DEFAULT '' NOT NULL,
  PRIMARY KEY (id),
  UNIQUE repository (repository)
);
DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
  repositoryid mediumint(9) DEFAULT '0' NOT NULL,
  branchid mediumint(9) DEFAULT '0' NOT NULL,
  dirid mediumint(9) DEFAULT '0' NOT NULL,
  fileid mediumint(9) DEFAULT '0' NOT NULL,
  revision varchar(32) binary DEFAULT '' NOT NULL,
  UNIQUE repositoryid (repositoryid,dirid,fileid,branchid,revision),
  KEY repositoryid_2 (repositoryid),
  KEY dirid (dirid),
  KEY fileid (fileid),
  KEY branchid (branchid)
);
