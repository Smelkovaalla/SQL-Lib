select g.genre_name, count(s.singer_name)
from genre as g
left join singer_genre as sg on g.id = sg.genre_id
left join singer as s on sg.singer_id = s.id
group by g.genre_name
order by count(s.id) desc;


select t.track_name, a.album_date
from album as a
left join track as t on t.album_id = a.id
where (a.album_date >= 2019) and (a.album_date <= 2020);


select a.album_name, AVG(t.duration)
from album as a
left join track as t on t.album_id = a.id
group by a.album_name
order by AVG(t.duration);


select distinct s.singer_name
from singer as s
where s.singer_name not in (
    select distinct s.singer_name
    from singer as s
    left join singer_album as sa on s.id = sa.singer_id
    left join album as a on a.id = sa.album_id
    where a.album_date = 2020
)
order by s.singer_name;


select distinct ca.collection_album_name
from collection_album as ca
left join collection_album_track as cat on ca.id = cat.collection_album_id
left join track as t on t.id = cat.track_id
left join album as a on a.id = t.album_id
left join singer_album as sa on sa.album_id = a.id
left join singer as s on s.id = sa.singer_id
where s.singer_name like '%%Allan%%'
order by ca.collection_album_name;


select a.album_name
from album as a
left join singer_album as sa on a.id = sa.album_id
left join singer as s on s.id = sa.singer_id
left join singer_genre as sg on s.id = sg.singer_id
left join genre as g on g.id = sg.genre_id
group by a.album_name
having count(distinct g.genre_name) > 1
order by a.album_name;


select t.track_name
from track as t
left join collection_album_track as cat on t.id = cat.track_id
where cat.track_id is null;


select s.singer_name, t.duration
from track as t
left join album as a on a.id = t.album_id
left join singer_album as sa on sa.album_id = a.id
left join singer as s on s.id = sa.singer_id
group by s.singer_name, t.duration
having t.duration = (select min(duration) from track)
order by s.singer_name;


select distinct a.album_name
from album as a
left join track as t on t.album_id = a.id
where t.album_id in (
    select album_id
    from track
    group by album_id
    having count(id) = (
        select count(id)
        from track
        group by album_id
        order by count
        limit 1
    )
)
order by a.album_name