/*
1.Prikazati cijenu knjiga typa “popular_comp”, zajedno sa srednjom cijenom 
  svih knjiga i razlikom u cijeni prikazane knjige i srednje cijene svih knjiga.
  Upit realizovati korištenjem podupita kao izraza unutar SELECT liste
*/

USE pubs
GO
SELECT title, price
	,(SELECT AVG (price) FROM titles) AS Prosjek
	,price-(SELECT AVG(price) FROM titles) AS Razlika
	,type
FROM titles
WHERE type='popular_comp'


/*
2.Prikazati za sve osobe ženskog spola:
  Titulu, Prezime i Ime, Zadatak realizovati preko podupita tako da je 
  "subquery" izvor podataka za vanjski upit.
*/

USE AdventureWorks2014
GO
SELECT P.Title, P.FirstName, P.LastName
FROM (SELECT Title, FirstName, LastName FROM Person.Person) AS P
WHERE P.Title LIKE 'Ms%'

/*
3.Prikazati listu kupaca koji su narucili više od 20 komada 
  proizvoda čiji je ID 23. 
  Za realizaciju zadatka koristiti korelacijski podupit
*/

USE Northwind
GO
SELECT ORD.OrderID, ORD.CustomerID
FROM Orders AS ORD
WHERE 20 < (SELECT Quantity
			FROM [Order Details] AS OD
			WHERE ORD.OrderID = OD.OrderID 
				  AND OD.ProductID = 23)
/*
4.Prikazati one izdavače koje su izdali više od pet naslova
*/

USE pubs
GO
SELECT T1.pub_id, COUNT (T2.pub_id) AS Ukupno
FROM titles AS T1
	INNER JOIN titles AS T2
ON T1.title_id = T2.title_id
GROUP BY T1.pub_id
HAVING COUNT (T2.pub_id) > 5