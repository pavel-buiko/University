select name, open_mode --name: Имя каждой PDB. 
from v$pdbs            --open_mode: Текущее состояние каждой PDB (например, "READ WRITE" для доступной для чтения и записи,
                       --"MOUNTED" для примонтированной, но не открытой PDB).
