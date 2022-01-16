# 20190726  cskim@wiztag.com
# FILENAME 현재 처리중인 파일명 
# FS 필드 구분자로 디폴트는 공백 
# RS 레코드 구분자로 디폴트는 새로운 라인 
# NF 현재 레코드의 필드 개수 
# NR 현재 레코드의 번호 
# OFS 출력할 때 사용하는 FS 
# ORS 출력할 때 사용하는 RS 
# $0 입력 레코드의 전체 
# $n 입력 레코드의 n번째 필드 

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

	# A, U 상관없이 파일명만 출력
	# sub 명령어는 문장의 첫번째 일치하는 부분만 수정함
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
	# svn2pvcs.bat 실행 후 b.out 파일의 내용이
	# server\Game.java 형태라면
	# \trunk\chess\server\Game.java 형태로 변경해줍니다. 
	#
	# svn2pvcs2.awk 구조가 \trunk 로부터 절대경로를 기준으로 만들어져서 그렇습니다. 
	# -----
	
	### https://WIN-J829O6VMG17/svn/sample/trunk/chess 형태로 체크아웃 받은 경우   (trunk 가 아닌 경우)
	#print "trunk\chess" fileName3	
	
	### svn co https://WIN-J829O6VMG17/svn/sample/trunk 형태로 체크아웃 받은 경우
	print fileName3
}

