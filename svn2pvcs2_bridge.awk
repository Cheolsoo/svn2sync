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

# 바꿔야 하는 영역은 ### 으로 검색

BEGIN { 
	#RS = "\n"
	
	### Linux 의 경우 FS는 / 문자 
	FS = "\\"
	No = 1
	
	print "@echo off"
	print "SET PVCS_NO_BANNER=TRUE"
	print "SETLOCAL ENABLEDELAYEDEXPANSION"
	
	print "\n" 	
	
	### mod1
	# pvcs 저장소 이름이 v:/test 의 경우
	#-----
	pdb="sample"
	
	### mod2
	# svn update 실행하는 경로 
	#-----
	srcHomeDir="C:\\pvcs\\svnWork\\neobrain-br\\bridge"
	
	
	# 2021.11.15  cskim@todaysystems.co.kr 010-2823-3414
	# svnWorkDir, srcHomeDir 두개는 같은 값이다. 아래에서 svnWorkDir 변수를 사용하는 곳이 있어 추가한다. 
	#-----
	svnWorkDir=srcHomeDir
	
	### mod3
	# pvcs 저장소와 동기화 되는 디렉터리 (이게 필요가 있나 cskim )
	#-----
	pvcsWorkDir="C:\\pvcs\\pvcsWork\\neobrain-br\\bridge"
	
	# Version Manager 계정
	#-----
	PCLI_ID="pvcs:pvcsadm"	
}
{
	print "\n"
	print "rem No=" No
	print "echo No=" No

	fullName=$0  		# trunk\chess\server\Game.java 
	dirName=$0			# trunk\chess\server\Game.java 
	dirName2=$0			# trunk\chess\server\Game.java 
	fileName=$NF		# Game.java 
	
	unixFullName=fullName
	gsub(/\\/,"/",unixFullName)
	
	print "cd /d \"" svnWorkDir "\""
	print "\n"
	
	print "rem svn 저장소에서 내려받은 경로의 아래에 "
	print "rem " fullName " 이 디렉터리면 skip"
	print "rem -----"
	
	print "if not exist \"" fullName "\" goto endJob" No 
	print "if exist \"" fullName "\\*\" goto endJob" No
	
	if ( fileName == "a.out" || fileName == "b.out" || fileName == "c.bat" || fileName == "c.cmd" ) {
		print "goto endJob" No
	}
	
	
	print "\n"	

	
	print "rem =========="	
	print "rem fullName= (" fullName ") "
	print "rem unixFullName= (" unixFullName ") "
	print "rem dirName=  (" dirName  ") "
	print "rem dirName2= (" dirName2 ") "
	print "rem fileName= (" fileName ") "
	print "rem =========="
	
	print "\n"
	
	# 아래는 경로 구분자로 \ 를 쓴다. 
	dirName = substr(fullName, 1, length(fullName) - length(fileName)) 			# dirName : fullName 문자열에서 파일명만 제외한 문자열
																				# ex) bridge\res\bridge.ico   
																				#     -->  dirName = bridge\res\ 
																				
																				# ex) bridge\res\bridge.ico   
																				#     123456789012345678901
																				#     1 ~ (21 - 10)  ==> 1 ~ 11  번째 문자 ==> bridge\res\
																				#
																				#     즉, dirName 는 bridge\res\  
																				
																				

	print "rem dirName=(" dirName ") "
	print "\n"
	
	sub("trunk/","",dirName)					# dirName 변수값(문자열) 에서 "trunk/" 문자열을 공백 ""으로 치환한다. 
	sub("trunk\\","",dirName) 					# dirName 문자열에서 "trunk\" 문자열을 공백으로 치환 
	gsub("/","\\",dirName) 						# dirName 문자열의 / 문자를 \ 문자로 치환 
	#gsub(/\\/,"/",dirName) 						# dirName 문자열의 / 문자를 \ 문자로 치환 ( 역슬래시 )
	
	print "rem \\ 문자를 / 문자로 변경후의 dirName=(" dirName ") "
	print "\n"
	


	# 아래것은 경로 구분자로 / 문자를 사용하기 위해 변환 
	dirName2 = dirName 
	
	#sub("trunk/","",dirName2) 					# 왜 있는지 모르겠다. Linux 에서 사용될 경우가 있을랑가 ???
	#sub("trunk\\","",dirName2)
	
	gsub(/\\/,"/",dirName2) 					# dirName  = bridge\res\
												# dirName2 = bridge/res/
												
	unixDirName = dirName2 						# unixDirName = bridge/res/ 
												
																				
	
	print "rem dirName2=(" dirName2 ") "
	print "rem unixDirName=(" unixDirName ") "	
	print "rem unixFullName=(" unixFullName ") "
	print "\n"
	
	
	# svnWork 디렉터리 아래에서 pvcsWork 디렉터리 아래로 복사
	#-----
	print "mkdir \"" pvcsWorkDir "\\" dirName "\" > NUL 2>&1" 								# pvcsWorkDir="C:\\pvcsWork\\test"
																				# dirName = bridge\res\ 
																				# mkdir c:\pvcsWork\test\bridge\res\ 
																				
	print "copy /y \"" svnWorkDir "\\" fullName "\"  \""  pvcsWorkDir "\\" fullName "\" > NUL 2>&1"
	
	

	
	
	
	
	DIR3=fullName 												# trunk\chess\client\board\newDir7\CVS7.java
																# 또는
																# server\Library\games.zip
	
	sub("trunk/","",DIR3) 										# chess\client\board\newDir7\CVS7.java
	sub("trunk\\","",DIR3) 
	
	DIR3 = substr(DIR3, 1, length(DIR3) - length(fileName)) 	# chess\client\board\newDir7\ 
	gsub(/\\/, "/", DIR3) 	 									# chess/client/board/newDir7/        ( 슬래시 --> 역슬래시 변환 ) 
																#
																# 또는 server/Library/games.zip 

	# DIR3= trunk/chess/client/board/newDir7/CVS7.java  에서 trunk/ 삭제된 chess/client/borad/newDir7/CVS7.java
	# 또는 아래의 형태도 있음
	# DIR3=server/Library/games.zip

	if (length(fileName)>1) {
		print "rem fullName=" fullName
		print "rem fileName=" fileName
		print "\n"

		print "cd /d \"" pvcsWorkDir "\\" dirName "\""

		print "echo INCLUDE v:/" pdb "/archives/pvcs.cfg > vcs.cfg"

		###
		# v:/test/archives/SRC/chess 저장소 구조   -   /archives/SRC/chess 로 하면 안됨 끝에 꼭 / 문자 있어야 함 
		#-----		
		print "echo VCSDir=\"v:/"  pdb "/archives/SRC/bridge/" unixDirName "\" >> vcs.cfg"

		print "\n"

		print "vlog -cvcs.cfg -b \"" fileName "\" > NUL 2>&1"
		print "\n"
		
		print "rem 저장소에 파일이 없는 경우 addJob" No " 로 jump"
		print "rem -----"
		print "if not !errorlevel! == 0 goto addJob" No

		print "\n"
		print "rem =========="
		print "rem errorlevel 이 0이 아니라면 저장소에 파일이 없다는 의미이므로"
		print "rem  위의 goto addJob 부분은 Add Workfile 실행하는 부분"
		print "rem 여기는 checkin 작업 실행하는 부분"
		print "rem =========="
		print "\n"

		print "vcs -cvcs.cfg -l \"" fileName "\""
		print "put -cvcs.cfg -q -f -m\"pvcs_vm_checkin_msg\" -v\"pvcs_vm_checkin_label\" \"" fileName "\""
	
		print "goto importArchive" No

		print "\n"
		print ":addJob" No
		print "rem 여기는 Add Workfile 작업하는 부분"
		print "\n"

		print "put -cvcs.cfg -q -f -m\"pvcs_vm_checkin_msg\" -t\"SVN Sync\" -v\"pvcs_vm_checkin_label\" \"" fileName "\""
		print "\n"


		print ":importArchive" No
		print "rem ImportArchive" No
		
		###
		#v:/test/archives/SRC/chess 구조 
		if ( DIR3 == fileName ) {
		  PPATH="/SRC/bridge/"
		} else {
			PPATH="/SRC/bridge/" DIR3
		}

		
		print "\n"
		print "rem ----------"
		print "rem DIR3= (" DIR3 ") "
		print "rem PPATH= (" PPATH ") "
		print "rem ----------"
		print "\n"
		
		# v:/test/archives/SRC/chess 구조
		#-----
		print "pcli IA -qw -prv:/" pdb " -pp\"" PPATH "\" -id" PCLI_ID " \"v:/" pdb "/archives/SRC/bridge/" dirName2 fileName "-arc\""
		print "\n"
		
		
		if ( length(DIR3) == 0 ) {
			print "goto endJob" No
		}
		
		print "rem pcli IA 가 실패하는 경우"
		print "if not !errorlevel! == 0 ("
			#for(i=1; i<=NF; ++i) {
			
			maxi=NF 
			print "  rem maxi = " maxi
			
			for(i=NF; i>1; i--) {
			
				### 확인
				print "  rem i=" i ", $i=" $i
				
				if ($i == "bridge") {
					continue
				} else {
					###
					# v:/test/archives/SRC/bridge 구조 
					printf ("  pcli GAL -id%s -pr\"v:/%s\" -pp\"/SRC/bridge", PCLI_ID, pdb)					
				}

				for(j=1; j<i-1; j++) {
				
					### 확인
					#print (" rem j=" j ", $j=" $j)
					
					if ($j == "bridge" || $j == "") { 
						#continue 
						printf ("/")
					} else {
						printf ("/%s", $j)
					}
				}
				
				printf ("\"\n\n")
				
				### 확인 
				print "  rem i=" i ", $i=" $i " , maxi=" maxi ", j=" j
				
				
				# end ---- 
				# pcli GAL -idpvcs:pvcsadm -pr"v:/sample" -pp"/SRC/chess/server/Library/checkers/client"				
				
				print   "  if !errorlevel! == 0  ("
				
				for (k=j; k < maxi; k++) {
				
					### 확인
					print "      rem i=" i ", $i=" $i " , maxi=" maxi ", j=" j ", k=" k ", $k=" $k 
					
					printf ("      pcli CP -id%s -prv:/%s -pp\"/SRC/bridge", PCLI_ID, pdb)
				

					for(l=1; l<k; l++) {
					
						### 확인 
						#print ("   rem l=" l ", $l=" $l)
					
						if ($l == "trunk" || $l == "") { 
							printf ("/")
						} else {
							printf ("/%s", $l)
						}
					}

					printf ("\" \"%s\"\n\n", $l)
				}
				
				print "      pcli IA -qw -prv:/" pdb " -pp\"" PPATH "\" -id" PCLI_ID " \"v:/" pdb "/archives/SRC/bridge/" dirName2 fileName "-arc\""
				#print "      echo pcli IA -prv:/" pdb " -pp\"" PPATH "\" \" v:/" pdb "/archives/SRC/chess/" dirName2 fileName "-arc\"" 
				print "      goto endJob" No
				
				#if (i == 2) {
				#	printf ("/\" \"v:/%s/archives", pdb)					
				#} else {
				#	printf ("\" \"v:/%s/archives", pdb)
				#}
				
				
				#for(j=1; j<i; j++) {
				#	if ($j == "trunk" || $j == "") { 
				#		#continue 
				#		printf ("/")
				#	} else {
				#		printf ("/%s", $j)
				#	}
				#}	
				
				#printf ("\n")
				
				# end ---
				# pcli CP -idpvcs:pvcsadm -pr"v:/sample" -pp"/SRC/chess" "
				
				print "  )"
				print "\n"
			}
			
		#print "pcli IA -prv:/" pdb " -pp\"" PPATH "\" -id" PCLI_ID " \"v:/" pdb "/archives/SRC/" dirName2 fileName "-arc\""
		#print "\n"
			
		print ")"
		
		print "\n"
		
		
		print ":endJob" No
	}
	
	No = No + 1;
}
END {
		print "endlocal"
		print "\n"
}

