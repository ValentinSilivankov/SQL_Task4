CREATE TABLE IF NOT EXISTS Compiliations_of_tracks (
	id SERIAL       PRIMARY KEY,
	Title           TEXT         NOT NULL,
	Year_of_release INTEGER      NOT NULL
);

CREATE TABLE IF NOT EXISTS Albums_of_executor (
	id SERIAL       PRIMARY KEY,
	Title           TEXT         NOT NULL,
	Year_of_release INTEGER      NOT NULL
);

CREATE TABLE IF NOT EXISTS Tracks (
	id SERIAL    PRIMARY KEY,
	Tracks_title VARCHAR(30)  NOT NULL,
	Duration     TIME(0)      NOT NULL,
	Album_id     INTEGER      NOT NULL
	REFERENCES Albums_of_executor(id)
);

CREATE TABLE IF NOT EXISTS TracksCompilations (
	Track_id       INTEGER REFERENCES Tracks(id),
	Compilation_id INTEGER REFERENCES Compilipublic.tracksations_of_tracks(id),
	CONSTRAINT pk1 PRIMARY KEY (Track_id, Compilation_id)
);
CREATE TABLE IF NOT EXISTS Genre_of_music (
	id SERIAL PRIMARY KEY,
	Title     VARCHAR(30)  NOT NULL
);
CREATE TABLE IF NOT EXISTS Executors (
	id SERIAL PRIMARY KEY,
	Nickname  VARCHAR(30)  NOT NULL
);
CREATE TABLE IF NOT EXISTS ExecutorsGenre (
	Executors_id   INTEGER REFERENCES Executors(id),
	Genre_id       INTEGER REFERENCES Genre_of_music(id),
	CONSTRAINT pk2 PRIMARY KEY (Executors_id, Genre_id)
);
CREATE TABLE IF NOT EXISTS ExecutorsAlbums (
	Executor_id    INTEGER REFERENCES Executors(id),
	Albums_id      INTEGER REFERENCES Albums_of_executor(id),
	CONSTRAINT pk3 PRIMARY KEY (Executor_id, Albums_id)
);