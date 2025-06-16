CREATE TABLE family_tree (
    id INTEGER PRIMARY KEY,
    name VARCHAR(5),
    parent_id INTEGER,
    birth_year INTEGER
);

INSERT INTO family_tree (id, name, parent_id, birth_year) VALUES (1, 'Alice', NULL, 1950);
INSERT INTO family_tree (id, name, parent_id, birth_year) VALUES (2, 'Bob', 1, 1975);
INSERT INTO family_tree (id, name, parent_id, birth_year) VALUES (3, 'Carol', 1, 1978);
INSERT INTO family_tree (id, name, parent_id, birth_year) VALUES (4, 'Dave', 2, 2000);
INSERT INTO family_tree (id, name, parent_id, birth_year) VALUES (5, 'Eve', 3, 2003);
INSERT INTO family_tree (id, name, parent_id, birth_year) VALUES (6, 'Frank', 2, 2005);
INSERT INTO family_tree (id, name, parent_id, birth_year) VALUES (7, 'Grace', 5, 2028);

SELECT * FROM family_tree;

WITH RECURSIVE descendants AS (
    -- Base case: Start with Alice
    SELECT id, name, parent_id, birth_year, 1 AS generation
    FROM family_tree
    WHERE name = 'Alice'
    
    UNION ALL
    
    -- Recursive case: Find children of previous generation
    SELECT f.id, f.name, f.parent_id, f.birth_year, d.generation + 1
    FROM family_tree f
    JOIN descendants d ON f.parent_id = d.id  
)
SELECT * FROM descendants;


WITH RECURSIVE ancestors AS (
    -- Base case: Start with Grace
    SELECT id, name, parent_id, 1 AS generation
    FROM family_tree
    WHERE name = 'Grace'
    
    UNION ALL
    
    -- Recursive case: Find parents of previous generation
    SELECT f.id, f.name, f.parent_id, a.generation + 1
    FROM family_tree f
    JOIN ancestors a ON f.id = a.parent_id
)
SELECT * FROM ancestors;

WITH RECURSIVE lineage AS (
    -- Base case: Start with individuals who have no parents
    SELECT id, name, parent_id, 1 AS depth
    FROM family_tree
    WHERE parent_id IS NULL
    
    UNION ALL
    
    -- Recursive case: Count generations for each descendant
    SELECT f.id, f.name, f.parent_id, l.depth + 1
    FROM family_tree f
    JOIN lineage l ON f.parent_id = l.id
)
SELECT * FROM lineage ORDER BY depth DESC LIMIT 1;

WITH RECURSIVE family_age AS (
    -- Base case: Start with individuals who have no parents
    SELECT id, name, parent_id, birth_year, birth_year AS oldest_birth_year
    FROM family_tree
    WHERE parent_id IS NULL
    
    UNION ALL
    
    -- Recursive case: Compare birth years through generations
    SELECT f.id, f.name, f.parent_id, f.birth_year, fa.oldest_birth_year
    FROM family_tree f
    JOIN family_age fa ON f.parent_id = fa.id
)
SELECT 
    name, 
    birth_year, 
    oldest_birth_year, 
    birth_year - oldest_birth_year AS age_gap 
FROM family_age 
ORDER BY age_gap DESC;

