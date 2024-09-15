--1
(SELECT act_fname as fname,act_lname as lname
FROM actor
)
UNION
 (SELECT dir_fname,dir_lname
 FROM director);

--2
(select mov_title,rev_name,rev_stars from movie,reviewer,rating
Where movie.mov_id=rating.mov_id and reviewer.rev_id=rating.rev_id and rev_stars>=7);
(select * from rating where rev_stars>=7);

--3
(select mov_title from movie
where movie.mov_id NOT IN (select mov_id from rating));

--4
select mov_title,mov_year,mov_duration,mov_rel_date,mov_rel_country
from movie
where mov_rel_country <> 'USA';

--5
select rev_name from reviewer
where rev_id IN (select rev_id
from rating
where rev_stars IS NULL);

--6
select rev_name,mov_title,rev_stars from reviewer,movie,rating 
where reviewer.rev_id=rating.rev_id and movie.mov_id=rating.mov_id and rev_name IS NOT NULL and rev_stars IS NOT NULL;

--7
moviedb=# select rev_name,mov_title from movie,reviewer where 1<=(select count(distinct(mov_id)) from rating,reviewer where reviewer.rev_id = rating.rev_id);

--8
select mov_title from movie
where movie.mov_id NOT IN (select mov_id from rating where rev_id IN (select rev_id from reviewer where rev_name='Paul Monks'));

--9
--min value among all rev_stars
select reviewer_name,mov_title,rev_stars from reviewer,movie,rating
where rating.mov_id=movie.mov_id and rating.rev_id=reviewer.rev_id and rev_id,mov_id IN (select mov_id,rev_id from rating where rev_stars=(select min(rev_stars) from rating));

--minimum average value of rev_stars
select reviewer_name,mov_title,rev_stars from reviewer,movie,rating
where rating.mov_id=movie.mov_id and rating.rev_id=reviewer.rev_id and rev_id,mov_id IN (select mov_id,rev_id from rating where rev_stars=(select min(s) from rating where s=(select avg(rev_stars) from rating group by mov_id)));

--10
select mov_title from movie where mov_id IN (select mov_id from mov_direction where dir_id=(select dir_id from director where dir_fname='James'and dir_lname='Cameron')); 

--11
(select rev_name from reviewer
where reviewer.rev_id NOT IN (select rev_id from rating));

--12
select act_fname,act_lname from actor
where act_id NOT IN (select act_id from movie_cast where mov_id IN (select mov_id from movie where mov_year>=1990 and mov_year<=2000));

--13
Select dir_fname,dir_lname,gen_title,count(distinct(mov_id)) from director, director, genres, movie
Order by dir_fname ASC, dir_lname ASC
Where genres.gen_id IN (select gen_id from movie_genres where movie_genres.mov_id=movie.mov_id) and director.dir_id IN (select dir_id from movie_direction where movie_direction.mov_id=movie.mov_id) 
Group by dir_id, gen_id;

--14
Select mov_title, mov_year, gen_title, dir_fname, dir_lname from movie, movie, genres, director, director 
Where genres.gen_id IN (select gen_id from movie_genres where movie_genres.mov_id=movie.mov_id) and director.dir_id IN (select dir_id from movie_direction where movie_direction.mov_id=movie.mov_id) ;

--15
Select gen_title, count(distinct(mov_id)), avg(mov_duration) from genres, movie, movie
Where gen_id IN (select gen_id from movie_genres where movie.mov_id=movie_genres.mov_id) 
Group by gen_id;

--16
Select mov_title, mov_year, dir_fname, dir_lname, act_fname, act_lname, role from movie, movie, director, director, actor, actor, movie_cast
Where movie.mov_id=movie_cast.mov_id and movie_cast.act_id=actor.act_id and director.dir_id IN (select dir_id from movie_direction where movie_direction.mov_id=movie.mov_id) and movie.mov_duration=(select min(mov_duration) from movie);

--17
select rev_name,mov_title,rev_stars from reviewer,movie,rating
where reviewer.rev_id=rating.rev_id and movie.mov_id=rating.mov_id;

--18
Select mov_title, dir_fname, dir_lname, rev_stars from movie, director, director, rating
Where rating.mov_id=movie.mov_id and director.dir_id IN (select dir_id from movie_direction where movie_direction.mov_id=movie.mov_id) 
Having rating.num_o_rating IS NOT NULL;

--19
Select mov_title, dir_fname, act_lname, role from movie, director, actor, movie_cast 
where actor.act_id=movie_cast.act_id and movie_cast.mov_id=movie.mov_id and director.dir_fname=actor.act_fname and director.dir_lname=actor.act_lname;

--20
select act_fname,act_lname from actor
where actor.act_id IN (select act_id from movie_cast where mov_id IN (select mov_id from movie where mov_title='Chinatown'));

--21
select mov_title from movie where mov_id IN (select mov_id from movie_cast where act_id IN (select act_id from actor where act_fname='Harrison' and act_lname='Ford'));

--22
select mov_title,mov_year,rev_stars from movie,movie,rating
where movie.mov_id=rating.mov_id and movie.mov_id IN (select mov_id from rating where rev_stars=(select max(rev_stars) from rating) and mov_id IN (select mov_id from movie_genres where gen_id=(select gen_id from genres where gen_title='Mystery Movies')));

--23
select mov_title,act_fname,act_lname,mov_year,role,gen_title,dir_fname,dir_lname,mov_rel_date,rev_stars from movie,actor,actor,movie,movie_cast,genres,director,director,movie,rating where movie.mov_id=rating.mov_id and actor.act_gender='F' and movie_cast.act_id=actor.act_act_id and dir_id IN (select dir_id from movie_direction where movie.mov_id=movie_direction.mov_id) and gen_id IN (select gen_id from movie_genres where movie_genres.mov_id=movie.mov_id);

--24
