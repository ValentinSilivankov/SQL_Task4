--Количество исполнителей в каждом жанре
SELECT genre_title, COUNT(executors_id)
  FROM genre_of_music AS gom
  LEFT JOIN executorsgenre AS eg
    ON gom.id = eg.genre_id
  LEFT JOIN executors AS e
    ON eg.executors_id = e.id
 GROUP BY gom.genre_title
 ORDER BY COUNT(e.id) DESC;

--Количество треков, вошедших в альбомы 2019-2020 годов
SELECT COUNT(tracks_title)
  FROM tracks AS t
  JOIN albums_of_executor AS aoe
    ON t.album_id = aoe.id
 WHERE aoe.year_of_release BETWEEN 2019 AND 2020;

--Средняя продолжительность треков по каждому альбому
SELECT album_title, AVG(duration)
  FROM albums_of_executor AS aoe
  JOIN tracks AS t
    ON t.album_id = aoe.id
 GROUP BY aoe.album_title
 ORDER BY avg(t.duration);

--Все исполнители, которые не выпустили альбомы в 2020 году
SELECT nickname
  FROM executors AS e
  JOIN albums_of_executor AS aoe
    ON e.id = aoe.id
 WHERE year_of_release != 2020;

--названия сборников, в которых присутствует конкретный исполнитель
SELECT compiliation_title
  FROM compiliations_of_tracks AS cot2
  JOIN trackscompilations AS tc
    ON cot2.id = tc.compilation_id
  JOIN tracks AS t
    ON t.id = tc.track_id
  JOIN albums_of_executor AS aoe
    ON aoe.id = t.album_id
  JOIN executorsalbums AS ea
    ON aoe.id = ea.albums_id
  JOIN executors AS e
    ON e.id = ea.executor_id
 WHERE nickname = 'OxxxyMiron'
 GROUP BY compiliation_title;

--Название альбомов, в которых присутствуют исполнители более 1 жанра
SELECT album_title
  FROM albums_of_executor AS aoe
  JOIN executorsalbums AS ea
    ON aoe.id = ea.albums_id
  JOIN executorsgenre AS eg
    ON ea.executor_id = eg.executors_id
 GROUP BY album_title
HAVING COUNT(eg.genre_id) > 1;

--Наименование треков, которые не входят в сборники
SELECT tracks_title
  FROM tracks AS t
  LEFT JOIN trackscompilations AS tc
    ON t.id = tc.track_id
 WHERE compilation_id IS NULL;
 
--Исполнителя(-ей), написавший самый короткий по продолжительности трек
SELECT nickname, duration
  FROM tracks AS t
  LEFT JOIN albums_of_executor AS aoe
    ON aoe.id = t.album_id
  LEFT JOIN executorsalbums AS ea
    ON ea.albums_id = aoe.id
  LEFT JOIN executors AS e
    ON e.id = ea.executor_id
 GROUP BY e.nickname, t.duration
HAVING t.duration = (SELECT MIN(duration) 
                       FROM tracks)
 ORDER BY e.nickname 

--Название альбомов, содержащих наименьшее количество треков
SELECT album_title, count(album_title)
  FROM albums_of_executor AS aoe
  JOIN tracks AS t
    ON t.album_id = aoe.id
 GROUP BY album_title
HAVING COUNT(album_title) = (SELECT MIN(COUNT(album_title)) OVER ()
                               FROM albums_of_executor AS aoe2
                               JOIN tracks AS t
                                 ON t.album_id = aoe2.id
                              GROUP BY album_title
                              LIMIT 1
                              );