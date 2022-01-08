-- Deletes tables if they exist
DROP TABLE IF EXISTS votes;
DROP TABLE IF EXISTS candidates;
DROP TABLE IF EXISTS parties;
DROP TABLE IF EXISTS voters;

-- Creates parties table
CREATE TABLE parties (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Creates candidates table
CREATE TABLE candidates (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    party_id INTEGER,
    industry_connected BOOLEAN NOT NULL,
    CONSTRAINT fk_party FOREIGN KEY (party_id) REFERENCES parties(id) ON DELETE SET NULL
    -- We've added a new line to the table called a constraint. This allows us to flag the party_id field as an official foreign key and tells SQL which table and field it references. In this case, it references the id field in the parties table. This ensures that no id can be inserted into the candidates table if it doesn't also exist in the parties table. MySQL will return an error for any operation that would violate a constraint. Because this constraint relies on the parties table, the parties table MUST be defined first before the candidates table. 
    -- Because we've established a strict rule that no candidate can be a member of a party that doesn't exist, we should also consider what should happen if a party is deleted. In this case, we added ON DELETE SET NULL to tell SQL to set a candidate's party_id field to NULL if the corresponding row in parties is ever deleted.
);

-- Creates voters table
CREATE TABLE voters (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Creates votes table
CREATE TABLE votes (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    voter_id INTEGER NOT NULL,
    candidate_id INTEGER NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uc_voter UNIQUE (voter_id),
    CONSTRAINT fk_voter FOREIGN KEY (voter_id) REFERENCES voters(id) ON DELETE CASCADE,
    CONSTRAINT fk_candidate FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE
);

