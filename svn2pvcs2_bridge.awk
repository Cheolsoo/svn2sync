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

# �ٲ�� �ϴ� ������ ### ���� �˻�

BEGIN { 
	#RS = "\n"
	
	### Linux �� ��� FS�� / ���� 
	FS = "\\"
	No = 1
	
	print "@echo off"
	print "SET PVCS_NO_BANNER=TRUE"
	print "SETLOCAL ENABLEDELAYEDEXPANSION"
	
	print "\n" 	
	
	### mod1
	# pvcs ����� �̸��� v:/test �� ���
	#-----
	pdb="sample"
	
	### mod2
	# svn update �����ϴ� ��� 
	#-----
	srcHomeDir="C:\\pvcs\\svnWork\\neobrain-br\\bridge"
	
	
	# 2021.11.15  cskim@todaysystems.co.kr 010-2823-3414
	# svnWorkDir, srcHomeDir �ΰ��� ���� ���̴�. �Ʒ����� svnWorkDir ������ ����ϴ� ���� �־� �߰��Ѵ�. 
	#-----
	svnWorkDir=srcHomeDir
	
	### mod3
	# pvcs ����ҿ� ����ȭ �Ǵ� ���͸� (�̰� �ʿ䰡 �ֳ� cskim )
	#-----
	pvcsWorkDir="C:\\pvcs\\pvcsWork\\neobrain-br\\bridge"
	
	# Version Manager ����
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
	
	print "rem svn ����ҿ��� �������� ����� �Ʒ��� "
	print "rem " fullName " �� ���͸��� skip"
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
	
	# �Ʒ��� ��� �����ڷ� \ �� ����. 
	dirName = substr(fullName, 1, length(fullName) - length(fileName)) 			# dirName : fullName ���ڿ����� ���ϸ� ������ ���ڿ�
																				# ex) bridge\res\bridge.ico   
																				#     -->  dirName = bridge\res\ 
																				
																				# ex) bridge\res\bridge.ico   
																				#     123456789012345678901
																				#     1 ~ (21 - 10)  ==> 1 ~ 11  ��° ���� ==> bridge\res\
																				#
																				#     ��, dirName �� bridge\res\  
																				
																				

	print "rem dirName=(" dirName ") "
	print "\n"
	
	sub("trunk/","",dirName)					# dirName ������(���ڿ�) ���� "trunk/" ���ڿ��� ���� ""���� ġȯ�Ѵ�. 
	sub("trunk\\","",dirName) 					# dirName ���ڿ����� "trunk\" ���ڿ��� �������� ġȯ 
	gsub("/","\\",dirName) 						# dirName ���ڿ��� / ���ڸ� \ ���ڷ� ġȯ 
	#gsub(/\\/,"/",dirName) 						# dirName ���ڿ��� / ���ڸ� \ ���ڷ� ġȯ ( �������� )
	
	print "rem \\ ���ڸ� / ���ڷ� �������� dirName=(" dirName ") "
	print "\n"
	


	# �Ʒ����� ��� �����ڷ� / ���ڸ� ����ϱ� ���� ��ȯ 
	dirName2 = dirName 
	
	#sub("trunk/","",dirName2) 					# �� �ִ��� �𸣰ڴ�. Linux ���� ���� ��찡 �������� ???
	#sub("trunk\\","",dirName2)
	
	gsub(/\\/,"/",dirName2) 					# dirName  = bridge\res\
												# dirName2 = bridge/res/
												
	unixDirName = dirName2 						# unixDirName = bridge/res/ 
												
																				
	
	print "rem dirName2=(" dirName2 ") "
	print "rem unixDirName=(" unixDirName ") "	
	print "rem unixFullName=(" unixFullName ") "
	print "\n"
	
	
	# svnWork ���͸� �Ʒ����� pvcsWork ���͸� �Ʒ��� ����
	#-----
	print "mkdir \"" pvcsWorkDir "\\" dirName "\" > NUL 2>&1" 								# pvcsWorkDir="C:\\pvcsWork\\test"
																				# dirName = bridge\res\ 
																				# mkdir c:\pvcsWork\test\bridge\res\ 
																				
	print "copy /y \"" svnWorkDir "\\" fullName "\"  \""  pvcsWorkDir "\\" fullName "\" > NUL 2>&1"
	
	

	
	
	
	
	DIR3=fullName 												# trunk\chess\client\board\newDir7\CVS7.java
																# �Ǵ�
																# server\Library\games.zip
	
	sub("trunk/","",DIR3) 										# chess\client\board\newDir7\CVS7.java
	sub("trunk\\","",DIR3) 
	
	DIR3 = substr(DIR3, 1, length(DIR3) - length(fileName)) 	# chess\client\board\newDir7\ 
	gsub(/\\/, "/", DIR3) 	 									# chess/client/board/newDir7/        ( ������ --> �������� ��ȯ ) 
																#
																# �Ǵ� server/Library/games.zip 

	# DIR3= trunk/chess/client/board/newDir7/CVS7.java  ���� trunk/ ������ chess/client/borad/newDir7/CVS7.java
	# �Ǵ� �Ʒ��� ���µ� ����
	# DIR3=server/Library/games.zip

	if (length(fileName)>1) {
		print "rem fullName=" fullName
		print "rem fileName=" fileName
		print "\n"

		print "cd /d \"" pvcsWorkDir "\\" dirName "\""

		print "echo INCLUDE v:/" pdb "/archives/pvcs.cfg > vcs.cfg"

		###
		# v:/test/archives/SRC/chess ����� ����   -   /archives/SRC/chess �� �ϸ� �ȵ� ���� �� / ���� �־�� �� 
		#-----		
		print "echo VCSDir=\"v:/"  pdb "/archives/SRC/bridge/" unixDirName "\" >> vcs.cfg"

		print "\n"

		print "vlog -cvcs.cfg -b \"" fileName "\" > NUL 2>&1"
		print "\n"
		
		print "rem ����ҿ� ������ ���� ��� addJob" No " �� jump"
		print "rem -----"
		print "if not !errorlevel! == 0 goto addJob" No

		print "\n"
		print "rem =========="
		print "rem errorlevel �� 0�� �ƴ϶�� ����ҿ� ������ ���ٴ� �ǹ��̹Ƿ�"
		print "rem  ���� goto addJob �κ��� Add Workfile �����ϴ� �κ�"
		print "rem ����� checkin �۾� �����ϴ� �κ�"
		print "rem =========="
		print "\n"

		print "vcs -cvcs.cfg -l \"" fileName "\""
		print "put -cvcs.cfg -q -f -m\"pvcs_vm_checkin_msg\" -v\"pvcs_vm_checkin_label\" \"" fileName "\""
	
		print "goto importArchive" No

		print "\n"
		print ":addJob" No
		print "rem ����� Add Workfile �۾��ϴ� �κ�"
		print "\n"

		print "put -cvcs.cfg -q -f -m\"pvcs_vm_checkin_msg\" -t\"SVN Sync\" -v\"pvcs_vm_checkin_label\" \"" fileName "\""
		print "\n"


		print ":importArchive" No
		print "rem ImportArchive" No
		
		###
		#v:/test/archives/SRC/chess ���� 
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
		
		# v:/test/archives/SRC/chess ����
		#-----
		print "pcli IA -qw -prv:/" pdb " -pp\"" PPATH "\" -id" PCLI_ID " \"v:/" pdb "/archives/SRC/bridge/" dirName2 fileName "-arc\""
		print "\n"
		
		
		if ( length(DIR3) == 0 ) {
			print "goto endJob" No
		}
		
		print "rem pcli IA �� �����ϴ� ���"
		print "if not !errorlevel! == 0 ("
			#for(i=1; i<=NF; ++i) {
			
			maxi=NF 
			print "  rem maxi = " maxi
			
			for(i=NF; i>1; i--) {
			
				### Ȯ��
				print "  rem i=" i ", $i=" $i
				
				if ($i == "bridge") {
					continue
				} else {
					###
					# v:/test/archives/SRC/bridge ���� 
					printf ("  pcli GAL -id%s -pr\"v:/%s\" -pp\"/SRC/bridge", PCLI_ID, pdb)					
				}

				for(j=1; j<i-1; j++) {
				
					### Ȯ��
					#print (" rem j=" j ", $j=" $j)
					
					if ($j == "bridge" || $j == "") { 
						#continue 
						printf ("/")
					} else {
						printf ("/%s", $j)
					}
				}
				
				printf ("\"\n\n")
				
				### Ȯ�� 
				print "  rem i=" i ", $i=" $i " , maxi=" maxi ", j=" j
				
				
				# end ---- 
				# pcli GAL -idpvcs:pvcsadm -pr"v:/sample" -pp"/SRC/chess/server/Library/checkers/client"				
				
				print   "  if !errorlevel! == 0  ("
				
				for (k=j; k < maxi; k++) {
				
					### Ȯ��
					print "      rem i=" i ", $i=" $i " , maxi=" maxi ", j=" j ", k=" k ", $k=" $k 
					
					printf ("      pcli CP -id%s -prv:/%s -pp\"/SRC/bridge", PCLI_ID, pdb)
				

					for(l=1; l<k; l++) {
					
						### Ȯ�� 
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

