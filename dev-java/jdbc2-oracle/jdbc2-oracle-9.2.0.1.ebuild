# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc2-oracle/jdbc2-oracle-9.2.0.1.ebuild,v 1.1 2003/05/14 23:25:05 absinthe Exp $

inherit java-pkg

S=${WORKDIR}
DESCRIPTION="JDBC Drivers for Oracle"
SRC_URI=""
HOMEPAGE="http://otn.oracle.com/software/tech/java/sqlj_jdbc/htdocs/jdbc9201.html"
KEYWORDS="x86 ppc sparc alpha"
LICENSE="oracle-jdbc"
SLOT="4"
DEPEND=""
RDEPEND=">=virtual/jdk-1.2"
IUSE="debug doc"

use debug && DISTFILE1=classes12_g.zip || DISTFILE1=classes12.zip
DISTFILE2=nls_charset12.zip
DISTFILE3=ocrs12.zip
DISTFILE4=javadoc.zip
FILE1=${P}-${DISTFILE1}
FILE2=${P}-${DISTFILE2}
FILE3=${P}-${DISTFILE3}
FILE4=${P}-${DISTFILE4}

src_unpack() {
	# Build File List
	FILELIST="${FILE1} ${FILE2} ${FILE3}"
	use doc > /dev/null && FILELIST="${FILELIST} ${FILE4}" 
	
	# Check for distributables
	echo " "
	for i in ${FILELIST} ; do
		if [ ! -f ${DISTDIR}/${i} ] ; then
			echo "!!! MISSING FILE: ${DISTDIR}/${i}"
			MISSING_FILES="true"
		else
			cp ${DISTDIR}/${i} ${S}
		fi
	done
	echo " "
	
	
	if [ "${MISSING_FILES}" == "true" ] ; then
		einfo " "
		einfo " Because of license terms and file name conventions, please:"
		einfo " "
		einfo " 1. Visit ${HOMEPAGE}"
		einfo "    (you may need to create an account on Oracle's site)"
		einfo " 2. Download the appropriate files:"
		einfo "    2a. ${DISTFILE1}"
		einfo "    2b. ${DISTFILE2}"
		einfo "    2c. ${DISTFILE3}"
		use doc > /dev/null && einfo "    2d. ${DISTFILE4}"
		einfo " 3. Rename the files:"
		einfo "    3a. ${DISTFILE1} ---> ${FILE1}"
		einfo "    3b. ${DISTFILE2} ---> ${FILE2}"
		einfo "    3c. ${DISTFILE3} ---> ${FILE3}"
		use doc > /dev/null && einfo "    3d. ${DISTFILE4} ---> ${FILE4}"
		einfo " 4. Place the files in ${DISTDIR}"
		einfo " 5. Repeat the emerge process to continue."
		einfo " "
		die "User must manually fetch/rename files"
	fi
	
	# Move files back to their original filenames
	mv ${S}/${FILE1} ${S}/${DISTFILE1}
	mv ${S}/${FILE2} ${S}/${DISTFILE2}
	mv ${S}/${FILE3} ${S}/${DISTFILE3}
	use doc && mv ${S}/${FILE4} ${S}/${DISTFILE4}
}

src_compile() {
	einfo " This is a binary-only (bytecode) ebuild."
} 

src_install() {
	if [ -n "`use doc`" ] ; then
		mkdir ${S}/javadoc
		cd ${S}/javadoc
		unzip ${DISTDIR}/${FILE4}
		dohtml -r ${S}/javadoc/
	fi
	java-pkg_dojar ${S}/*.zip
}

