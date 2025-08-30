CREATE TABLE special_feature(
special_feature_id INT NOT NULL PRIMARY KEY, 
name VARCHAR(50)
);

CREATE UNIQUE INDEX IDX_SPECIAL_FEATURE_NAME 
ON special_feature (name);

CREATE INDEX IDX_CUSTOMER_FIRST_LAST_NAME
ON customer (first_name, last_name);

CREATE CLUSTERED INDEX IDX_CUSTOMER_CUSTOMER_ID
ON customer (customer_id ASC);

CREATE INDEX IDX_CUSTOMER_LAST_NAME
on customer (last_name ASC);

CHECK (rental_rate > 0)

DEFAULT 1

CREATE TABLE special_feature( 
special_feature_id INT NOT NULL PRIMARY KEY,  
name VARCHAR(50) 
);

CREATE TABLE film_special_feature( 
film_id INT,
special_feature_id INT,
FOREIGN KEY (film_id) REFERENCES film(film_id),
FOREIGN KEY (special_feature_id) REFERENCES special_feature(special_feature_id)
);

INSERT INTO special_feature (special_feature_id, name) VALUES (1, 'Trailers');
INSERT INTO special_feature (special_feature_id, name) VALUES (2, 'Deleted Scenes');
INSERT INTO special_feature (special_feature_id, name) VALUES (3, 'Behind the Scenes');
INSERT INTO special_feature (special_feature_id, name) VALUES (4, 'Commentaries');

INSERT INTO film_special_feature (film_id, special_feature_id) 
  SELECT 1, film_id FROM film WHERE special_features LIKE '%Trailers%';

INSERT INTO film_special_feature (film_id, special_feature_id) 
 SELECT 2, film_id FROM film WHERE special_features LIKE '%Deleted Scenes%';

INSERT INTO film_special_feature (film_id, special_feature_id) 
 SELECT 3, film_id FROM film WHERE special_features LIKE '%Behind the Scenes%';

INSERT INTO film_special_feature (film_id, special_feature_id) 
 SELECT 4, film_id FROM film WHERE special_features LIKE '%Commentaries%';
