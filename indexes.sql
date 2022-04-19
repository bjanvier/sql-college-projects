-- > a. select on_flag, count(*) from light_history where datetime = '2016-01-01 00:01:00' group by on_flag;
-- BEFORE:

    -- DROP INDEX lig_hist_index ON light_history
    ANALYZE select on_flag, count(*) from light_history where datetime = '2016-01-01 00:01:00' group by on_flag;

    --  Showing rows 0 - 0 (1 total, Query took 0.0010 seconds.)

    -- Host: localhost
    -- Database: jzagabe1
    -- Generation Time: May 06, 2019 at 03:39 AM
    -- Generated by: phpMyAdmin 4.4.15.10 / MySQL 10.3.4-MariaDB
    -- SQL query: -- Testing: ANALYZE select on_flag, count(*) from light_history where datetime = '2016-01-01 00:01:00' group by on_flag;
    -- Rows: 1
    --  Table results

    -- id	select_type	table	        type	   possible_keys	key	    key_len	    ref	    rows	r_rows	    filtered	r_filtered	Extra
    -- 1	SIMPLE	    light_history	 ALL	    NULL	        NULL	    NULL	NULL	500	    500.00	    100.00	    0.20	    Using where; Using temporary; Using filesort

-- AFTER:
    CREATE or REPLACE UNIQUE INDEX lig_hist_index ON light_history(datetime); 

    ANALYZE select on_flag, count(*) from light_history where datetime = '2016-01-01 00:01:00' group by on_flag;

    -- Showing rows 0 - 0 (1 total, Query took 0.0004 seconds.) For light_history table
    -- Host: localhost
    -- Database: jzagabe1
    -- Generation Time: May 06, 2019 at 03:59 AM
    -- Generated by: phpMyAdmin 4.4.15.10 / MySQL 10.3.4-MariaDB
    -- SQL query: ANALYZE select on_flag, count(*) from light_history where datetime = '2016-01-01 00:01:00' group by on_flag;
    -- Rows: 1

    --  Table results
    -- id	select_type	table	type	possible_keys	key	key_len	ref	rows	r_rows	filtered	r_filtered	Extra
    -- 1	SIMPLE	light_history	const	lig_hist_index	lig_hist_index	6	const	1	NULL	100.00	NULL	


-- > b. select count(distinct first_name) from address a inner join people p on p.id = a.person_id where a.state = 'IL';

-- BEFORE
        -- DROP INDEX address_indexes ON address
        -- DROP INDEX people_indexes ON people
        
        ANALYZE select 
    	    count(distinct first_name) 
        from address a 
        	inner join people p on p.id = a.person_id 
        where a.state = 'IL';

        --  Showing rows 0 - 1 (2 total, Query took 0.0157 seconds.)

        -- Host: localhost
        -- Database: jzagabe1
        -- Generation Time: May 06, 2019 at 04:06 AM
        -- Generated by: phpMyAdmin 4.4.15.10 / MySQL 10.3.4-MariaDB
        -- SQL query: ANALYZE select count(distinct first_name) from address a inner join people p on p.id = a.person_id where a.state = 'IL';
        -- Rows: 2

        -- id	select_type	table	type	possible_keys	key	    key_len	ref	    rows	r_rows	filtered	r_filtered	Extra
        -- 1	SIMPLE	    p	    ALL	    NULL	        NULL	NULL	NULL	1000	1000.00	100.00	    100.00	
        -- 1	SIMPLE	    a	    ALL	    NULL	        NULL	NULL	NULL	3000	3000.00	100.00	    0.00	    Using where; Using join buffer (flat, BNL join)

-- After:
        --  CREATE or REPLACE UNIQUE INDEX address_indexes ON address(address, city); 

        -- CREATE or REPLACE UNIQUE INDEX people_indexes ON people(first_name, last_name, email); 

        ANALYZE select 
        	count(distinct first_name) 
        from 
        	address a 
        	inner join people p on p.id = a.person_id 
        where 
        	a.state = 'IL';
            -- Showing rows 0 - 1 (2 total, Query took 0.0147 seconds.) I created an index for people table, then run ANALYZE command

            --  Host: localhost
            -- Database: jzagabe1
            -- Generation Time: May 06, 2019 at 04:10 AM
            -- Generated by: phpMyAdmin 4.4.15.10 / MySQL 10.3.4-MariaDB
            -- SQL query: ANALYZE select count(distinct first_name) from address a inner join people p on p.id = a.person_id where a.state = 'IL';
            -- Rows: 2

            -- id	select_type	table	type	possible_keys	key	    key_len	ref	    rows	r_rows	filtered	r_filtered	Extra
            -- 1	SIMPLE	    p	    ALL	    NULL	        NULL	NULL	NULL	1000	1000.00	100.00	    100.00	
            -- 1	SIMPLE	    a	    ALL	    NULL	        NULL	NULL	NULL	3000	3000.00	100.00	    0.00	    Using where; Using join buffer (flat, BNL join)

            -- for the index I created for address table, then after ANALYSE command, I got this:
            --  Showing rows 0 - 1 (2 total, Query took 0.0148 seconds.)

            -- Host: localhost
            -- Database: jzagabe1
            -- Generation Time: May 06, 2019 at 04:12 AM
            -- Generated by: phpMyAdmin 4.4.15.10 / MySQL 10.3.4-MariaDB
            -- SQL query: ANALYZE select count(distinct first_name) from address a inner join people p on p.id = a.person_id where a.state = 'IL';
            -- Rows: 2

            -- id	select_type	table	type	possible_keys	key	    key_len	ref	    rows	r_rows	filtered	r_filtered	Extra
            -- 1	SIMPLE	    p	    ALL	    NULL	        NULL	NULL	NULL	1000	1000.00	100.00	    100.00	
            -- 1	SIMPLE	    a	    ALL	    NULL	        NULL	NULL	NULL	3000	3000.00	100.00	    0.00	    Using where; Using join buffer (flat, BNL join)
    
