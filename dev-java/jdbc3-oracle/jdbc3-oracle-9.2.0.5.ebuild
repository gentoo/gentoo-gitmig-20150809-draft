# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc3-oracle/jdbc3-oracle-9.2.0.5.ebuild,v 1.1 2004/10/20 11:01:44 absinthe Exp $

inherit java-pkg

IUSE="debug doc"

file_main_orig=ojdbc14.jar
file_main_debug_orig=ojdbc14_g.jar
file_rowset_orig=ocrs12.zip
file_doc_orig=javadoc.tar

file_main=${P}-${file_main_orig}
file_main_debug=${P}-${file_main_debug_orig}
file_rowset=${P}-${file_rowset_orig}
file_doc=${P}-${file_doc_orig}

S=${WORKDIR}
DESCRIPTION="JDBC 3.0 Drivers for Oracle"
HOMEPAGE="http://otn.oracle.com/software/tech/java/sqlj_jdbc/htdocs/jdbc9201.html"
SRC_URI="${file_rowset} ${file_main}
		doc? ( ${file_doc} )
		debug? ( ${file_main_debug} )"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
LICENSE="oracle-jdbc"
SLOT="4"
DEPEND=">=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jdk-1.4"
RESTRICT="fetch"

pkg_nofetch() {
	einfo " "
	einfo " Because of license terms and file name conventions, please:"
	einfo " "
	einfo " 1. Visit ${HOMEPAGE}"
	einfo "    (you may need to create an account on Oracle's site)"
	einfo " 2. Download the appropriate files:"
	einfo "    - ${file_main_orig}"
	einfo "    - ${file_rowset_orig}"
	use doc > /dev/null && einfo "    - ${file_doc_orig}"
	use debug > /dev/null && einfo "    - ${file_main_debug_orig}"
	einfo " 3. Rename the files:"
	einfo "    - ${file_main_orig} --> ${file_main}"
	einfo "    - ${file_rowset_orig} --> ${file_rowset}"
	use doc > /dev/null && einfo "    - ${file_doc_orig} --> ${file_doc}"
	use debug > /dev/null && einfo "    - ${file_main_debug_orig} --> ${file_main_debug}"
	einfo " 4. Place the files in ${DISTDIR}"
	einfo " 5. Repeat the emerge process to continue."
	einfo " "
}

src_unpack() {
	use debug && cp ${DISTDIR}/${file_main_debug} ${S}/${file_main_debug_orig} || cp ${DISTDIR}/${file_main} ${S}/${file_main_orig}
	cp ${DISTDIR}/${file_rowset} ${S}/${file_rowset_orig}

	if use doc; then
		mkdir ${S}/javadoc
		cd ${S}/javadoc
		tar -xf ${DISTDIR}/${file_doc}
	fi
}

src_compile() {
	einfo " This is a binary-only (bytecode) ebuild."
}

src_install() {
	use doc && java-pkg_dohtml -r ${S}/javadoc/
	java-pkg_dojar ${S}/*.zip
	java-pkg_dojar ${S}/*.jar
}
