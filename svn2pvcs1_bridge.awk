# 20190726  cskim@wiztag.com
# FILENAME ���� ó������ ���ϸ� 
# FS �ʵ� �����ڷ� ����Ʈ�� ���� 
# RS ���ڵ� �����ڷ� ����Ʈ�� ���ο� ���� 
# NF ���� ���ڵ��� �ʵ� ���� 
# NR ���� ���ڵ��� ��ȣ 
# OFS ����� �� ����ϴ� FS 
# ORS ����� �� ����ϴ� RS 
# $0 �Է� ���ڵ��� ��ü 
# $n �Է� ���ڵ��� n��° �ʵ� 

function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }
function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s }
function trim(s) { return rtrim(ltrim(s)); }

BEGIN { 
	#RS = "\n"
	#FS = "-arc - "
	No = 1
}
{
	command=$1
	fileName=$0
	#print "command=(" command ")"
	#print "fileName=(" fileName ")"	
	#print "\n"

	# A, U ������� ���ϸ� ���
	# sub ��ɾ�� ������ ù��° ��ġ�ϴ� �κи� ������
	# -----
	if ( command == "A" || command == "a" || command == "U" || command == "u" ) {
		sub(command, "", fileName)
	} else if ( command == "D" || command == "d" ) {
		sub(command, "", fileName)
	}
	  else if ( command == "Restored" ) {
		sub(command, "", fileName)
	} else {
		next
	}
	fileName2=ltrim(fileName)
	fileName3=fileName2 
	gsub("'","",fileName3)
	#fileName3=substr(fileName2, 2, length(fileName2) -2)
	#print "fileName2=(" fileName2 ")"
	
	
	# 2022.01.16 nabiro@gmail.com	
	# svn2pvcs.bat ���� �� b.out ������ ������
	# server\Game.java ���¶��
	# \trunk\chess\server\Game.java ���·� �������ݴϴ�. 
	#
	# svn2pvcs2.awk ������ \trunk �κ��� �����θ� �������� ��������� �׷����ϴ�. 
	# -----
	
	### https://WIN-J829O6VMG17/svn/sample/trunk/chess ���·� üũ�ƿ� ���� ���   (trunk �� �ƴ� ���)
	#print "trunk\chess" fileName3	
	
	### svn co https://WIN-J829O6VMG17/svn/sample/trunk ���·� üũ�ƿ� ���� ���
	print fileName3
}

