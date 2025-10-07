
/* Mise à jour de la table rôles
Modifier la table t_role. Ajouter une colonne role_level (nombre entier, obligatoire, valeur par défaut: 0). La colonne "role_level" permettra de connaitre le niveau d'autorisation du rôle. */

ALTER TABLE t_role
	ADD COLUMN role_level INT NOT NULL DEFAULT '0';
	
	
/* Mettre à jour le niveau de chaque rôle : */
	

UPDATE t_role SET role_level='0' WHERE role_id='1';

UPDATE t_role SET role_level='9' WHERE role_id='2';

UPDATE t_role SET role_level='10' WHERE role_id='3';



/*  Ajouter les rôles suivants : */

INSERT INTO t_role
(role_name, role_description, role_level, role_register_code)
VALUES 
('employé', 'les salariés', '1', '7896'),
('cadre', 'les managers', '2', 'asd44'),
('dirigeant', 'la bigg boss', '3', '4561');


/* Ajouter les 5 utilisateurs suivants */

INSERT INTO t_user
(user_lastname, user_firstname, user_email, user_password, role_id)
VALUES
('danloss', 'ella', 'ella.danloss@example.com', '12345', '4'),
('golay', 'jerry', 'j.golay@example.fr', 'azerty', '4'),
('camant', 'medhi', 'medhi@example.fr', 'password', '5'),
('javelle', 'aude', 'aj@example.com', '121180', '4'),
('scroute', 'jessica', 'jescr@example.fr', '231297', '6');

/* INSERT INTO t_user
(user_lastname, user_firstname, user_email, user_password, role_id)
VALUES
('danloss', 'ella', 'ella.danloss@example.com', '12345', (SELECT role_id FROM t_role WHERE role_name = 'employé')),
('golay', 'jerry', 'j.golay@example.fr', 'azerty', '4'),
('camant', 'medhi', 'medhi@example.fr', 'password', '5'),
('javelle', 'aude', 'aj@example.com', '121180', '4'),
('scroute', 'jessica', 'jescr@example.fr', '231297', '6'); */

/* 1-Sélectionner tous les utilisateurs (identifiant nom, prénom, email et nom du rôle). */


/*SANS JOINTURE*/
/*SELECT user_id, user_lastname, user_firstname, user_email, role_name
FROM t_user, t_role
WHERE t_user.role_id = t_role.role_id;*/

SELECT user_id, user_lastname, user_firstname, user_email, t_user.role_id
FROM t_user, t_role
WHERE t_user.role_id = t_role.role_id;

/*AVEC JOINTURE*/

SELECT user_id, user_lastname, user_firstname, user_email, role_name
FROM t_user
INNER JOIN t_role ON t_user.role_id = t_role.role_id;

/*
SELECT user_id, user_lastname, user_firstname, user_email, t_rolerole_id, role_name
FROM t_user INNER JOIN t_role ON t_user.role_id = t_role.role_id
ORDER BY t_role,role_id DESC, user_lastname ASC;*/

/*2-Sélectionner tous les utilisateurs (identifiant nom, prénom, email, identifiant du rôle, nom du rôle). Trier les résultats par idetnfiant de rôle par ordre décroissant puis par nom de famille par ordre croissant.*/

SELECT user_id, user_lastname, user_firstname, user_email, t_role.role_id, role_name
FROM t_user 
INNER JOIN t_role 
ON t_user.role_id = t_role.role_id
ORDER BY t_role.role.id DESC, user_lastname ASC;

/*3-Sélectionner tous les utilisateurs (identifiant nom, prénom, email, identifiant du rôle, nom du rôle) 
qui possèdent le rôle n°2*/

SELECT user_id, user_lastname, user_firstname, user_email, t_role.role_id, role_name
FROM t_user
INNER JOIN t_role ON t_user.role_id = t_role.role_id
WHERE t_role.role_id=2;


/*4-Sélectionner le nombre d'utilisateurs.*/

SELECT COUNT(user_id) FROM t_user;


/*5-Sélectionner, dans les rôles, le plus grand identifiant.*/

SELECT MAX(role_id) FROM t_role


/*6-Sélectionner tous les rôles (identifiant du rôle, nom du rôle, description du rôle). Pour chaque rôle, afficher le nombre d'utilisateurs concernés.*/

SELECT role_name, role_description, COUNT(user_id)
FROM t_role
INNER JOIN t_user ON t_user.role_id = t_role.role_id
GROUP BY t_role.role_id;


/*7 Sélectionner la moyenne du nombre d'utilisateurs par rôle.*/

SELECT 
	(SELECT  COUNT(user_id) FROM t_user) 
	/ 
	(SELECT COUNT(role_id) FROM t_role);
/* SELECT pour selectionner les sous requétes dans notre cas le nombre id utilisateurs
diviser par la selection la deuxiéme sous requéte le nombre de rôle*/

/*-8 Sélectionner nom, prénom, nom du rôle de tous les utilisateurs avec pour chaque utilisateur 
l'identifiant et nom de l'utilisateur possédant le même rôle et l'identifiant le plus petit.*/

	
/*SELECT 
user_id, 
user_lastname, 
user_firstname, 
role_name,
t_user.role_id,
(SELECT U.role_id FROM t_user AS U WHERE t_role.role_id = U.role_id AND t_user.user_id > U.user_id LIMIT 1) AS user_2_role,
(SELECT MIN(U1.user_id) FROM t_user AS U1 WHERE t_role.role_id = U1.role_id AND t_user.user_id > U1.user_id LIMIT 1) AS user_2_id,
(SELECT U2.user_lastname FROM t_user AS U2 WHERE t_role.role_id = U2.role_id AND t_user.user_id > U2.user_id LIMIT 1) AS user_2_lastname
FROM t_user
JOIN t_role ON t_role.role_id = t_user.role_id;*/	
	
	SELECT 
user_id, 
user_lastname, 
user_firstname, 
role_name,
t_user.role_id,
(SELECT t_user.role_id FROM t_user WHERE t_role.role_id = t_user.role_id LIMIT 1) AS user_2_role,
(SELECT MIN(user_id) FROM t_user WHERE t_role.role_id = t_user.role_id) AS user_2_id,
(SELECT user_lastname FROM t_user WHERE t_role.role_id = t_user.role_id LIMIT 1) AS user_2_lastname
FROM t_user 
JOIN t_role ON t_role.role_id = t_user.role_id;
	
	
/*jointure auto (self-join)*/

SELECT
    u1.user_id,
    u1.user_lastname,
    u1.user_firstname,
    r.role_name,
    u1.role_id,
    -- On joint avec un autre utilisateur du même rôle (différent de l'utilisateur courant)
    u2.user_id AS user_2_id,
    u2.user_lastname AS user_2_lastname,
    u2.role_id AS user_2_role
FROM
    t_user u1
JOIN
    t_role r ON r.role_id = u1.role_id
-- Jointure auto : on joint t_user avec elle-même sur le rôle, en excluant l'utilisateur courant
LEFT JOIN
    t_user u2 ON u1.role_id = u2.role_id AND u1.user_id != u2.user_id
-- Optionnel : pour ne garder qu'un seul "exemple" par rôle, on peut ajouter une condition pour prendre le plus petit user_id
-- (sinon, il y aura une ligne par combinaison d'utilisateurs du même rôle)
WHERE
    u2.user_id = (SELECT MIN(user_id) FROM t_user WHERE role_id = u1.role_id AND user_id != u1.user_id)
    OR u2.user_id IS NULL; -- Pour les rôles n'ayant qu'un seul utilisateur


/*requête pré-agrégée*/

WITH role_examples AS (
    -- Pour chaque rôle, on garde l'utilisateur avec le plus petit user_id
    SELECT
        role_id,
        MIN(user_id) AS example_user_id,
        user_lastname AS example_user_lastname
    FROM
        t_user
    GROUP BY
        role_id, user_lastname
    -- On ne garde que le plus petit user_id par rôle
    QUALIFY ROW_NUMBER() OVER (PARTITION BY role_id ORDER BY user_id) = 1
)

SELECT
    u.user_id,
    u.user_lastname,
    u.user_firstname,
    r.role_name,
    u.role_id,
    re.example_user_id AS user_2_id,
    re.example_user_lastname AS user_2_lastname,
    re.role_id AS user_2_role
FROM
    t_user u
JOIN
    t_role r ON r.role_id = u.role_id
LEFT JOIN
    role_examples re ON u.role_id = re.role_id;

