CREATE DATABASE IF NOT EXISTS dspam;
GRANT USAGE ON dspam.* TO 'dspam'@'localhost' IDENTIFIED BY '@password@';
GRANT SELECT, INSERT, UPDATE, DELETE ON dspam.* TO 'dspam'@'localhost';
USE dspam;
