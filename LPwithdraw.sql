CREATE FUNCTION LAwithdraw(tb text) RETURNS void
AS $T1$
BEGIN
--  delete the extra 3 columns of the target table
    EXECUTE format('ALTER TABLE %s DROP COLUMN alphavalue;', tb);
    EXECUTE format('ALTER TABLE %s DROP COLUMN nIncomplete;', tb);
    EXECUTE format('ALTER TABLE %s DROP COLUMN Ibitmap;', tb);

--  drop the temporary table for Lattices
    EXECUTE format('DROP TABLE %s;', tb || '_LATMP');

--  drop triggers
    EXECUTE format('DROP TRIGGER %s_lainup ON %s;', tb, tb);
    EXECUTE format('DROP FUNCTION lp_%s_triinup();', tb);
    EXECUTE format('DROP TRIGGER %s_ladel ON %s', tb, tb);
    EXECUTE format('DROP FUNCTION lp_%s_tridel();', tb);

--  drop function (for debugging)
    EXECUTE 'DROP FUNCTION lpinit(text);';

--  drop extension (for debugging)
    DROP EXTENSION hstore;
END
$T1$
language plpgsql;
