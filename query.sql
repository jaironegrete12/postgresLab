DROP TABLE IF EXISTS CONTENT;
CREATE TABLE CONTENT (
	content_code SERIAL NOT NULL PRIMARY KEY,
	description CHARACTER VARYING (255)
);

DROP FUNCTION IF EXISTS notify_realtime;
CREATE FUNCTION notify_realtime () RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
	PERFORM pg_notify ('addedrecord',	TG_TABLE_NAME) ; 
	RETURN NULL ;
END ; 
$$;

DROP TRIGGER IF EXISTS updated_realtime_trigger ON CONTENT;
CREATE TRIGGER updated_realtime_trigger AFTER INSERT ON CONTENT FOR EACH ROW EXECUTE PROCEDURE notify_realtime ();