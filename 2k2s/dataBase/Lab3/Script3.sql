select name, open_mode --name: ��� ������ PDB. 
from v$pdbs            --open_mode: ������� ��������� ������ PDB (��������, "READ WRITE" ��� ��������� ��� ������ � ������,
                       --"MOUNTED" ��� ����������������, �� �� �������� PDB).
