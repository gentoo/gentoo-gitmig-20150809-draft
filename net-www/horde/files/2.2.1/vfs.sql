-- $Horde: horde/scripts/db/vfs.sql,v 1.3 2002/08/19 20:13:49 chuck Exp $

CREATE TABLE horde_vfs (
    vfs_id        BIGINT NOT NULL,
    vfs_type      SMALLINT NOT NULL,
    vfs_path      VARCHAR(255) NOT NULL,
    vfs_name      VARCHAR(255) NOT NULL,
    vfs_modified  BIGINT NOT NULL,
    vfs_owner     VARCHAR(255) NOT NULL,
    vfs_data      LONGBLOB,
-- Or, on some DBMS systems:
--  vfs_data      IMAGE,
    PRIMARY KEY   (vfs_id)
);

CREATE INDEX vfs_path_idx ON horde_vfs (vfs_path);
CREATE INDEX vfs_name_idx ON horde_vfs (vfs_name);

GRANT SELECT, INSERT, UPDATE, DELETE ON horde_vfs TO horde;
