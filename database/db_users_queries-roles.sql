
/* Modifier le nom du rôle n°2 en "Modérateur". */

UPDATE t_role SET role_name='modérateur' WHERE role_id=2;

/* Modifier le rôle n°1.
	Nouveau nom : padawan
	Nouvelle description : Les petits nouveaux */
	
UPDATE t_role SET 
role_name='padawan', 
role_description='les petits nouveaux' 
WHERE role_id= '1';



/*Sélectionner toutes les informations de tous les rôles*/

SELECT * FROM t_role;/* (* = toutes les colonnes) */														/* ASC = ascendant DESC = descendant*/	

SELECT role_id, role_name, role_description, role_register_code FROM t_role ORDER BY role_name DESC; /* , role_name ASC*/


/*Sélectionner l'identifiant, le nom du rôle et la description de chaque rôle*/

SELECT role_id, role_name,role_description FROM t_role;


/* Sélectionner l'identifiant et le nom du rôle n°3. */

SELECT role_id, role_name FROM t_role WHERE role_id=3;


/* Sélectionner l'identifiant, le nom et la description du rôle dont le libellé est "modérateur". */

SELECT role_id, role_name, role_description FROM t_role WHERE role_name ='modérateur';


/* Sélectionner toutes les informations des rôles dont la description est vide. */

SELECT role_id, role_name, role_description, role_register_code FROM t_role WHERE role_description IS NULL OR role_description='';

/* Sélectionner toutes les informations des rôles dont la description n'est pas vide. */

SELECT role_id, role_name, role_description, role_register_code FROM t_role WHERE role_description IS NOT NULL OR AND role_description <> '';


/* Sélectionner l'identifiant, le nom des rôles dont le nom contient la chaine "ra". */

SELECT role_id, role_name FROM t_role WHERE role_name LIKE '%ra%';


/* Sélectionner l'identifiant, le nom et la description des rôle dont le nom se termine par la lettre "r". */
SELECT role_id, role_name FROM t_role WHERE role_name LIKE '%r';


/* Sélectionner l'identifiant, le nom et la description des rôle dont le nom se commence par la lettre "r". */
SELECT role_id, role_name FROM t_role WHERE role_name LIKE 'r%';