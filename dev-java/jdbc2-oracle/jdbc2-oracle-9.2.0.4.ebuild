# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc2-oracle/jdbc2-oracle-9.2.0.4.ebuild,v 1.5 2007/07/11 19:58:37 mr_bones_ Exp $

inherit java-pkg

file_main_orig=classes12.zip
file_main_debug_orig=classes12_g.zip
file_rowset_orig=ocrs12.zip
file_nls_orig=nls_charset12.zip
file_doc_orig=javadoc.tar

file_main=${P}-${file_main_orig}
file_main_debug=${P}-${file_main_debug_orig}
file_rowset=${P}-${file_rowset_orig}
file_nls=${P}-${file_nls_orig}
file_doc=${P}-${file_doc_orig}

S=${WORKDIR}
DESCRIPTION="JDBC Drivers for Oracle"
IUSE="debug doc"
SRC_URI="${file_main} ${file_rowset} ${file_nls}
	debug? ( ${file_main_debug} )
	doc? ( ${file_doc} )
"
HOMEPAGE="http://otn.oracle.com/software/tech/java/sqlj_jdbc/htdocs/jdbc9201.html"
KEYWORDS="~x86 ~ppc ~amd64"
LICENSE="oracle-jdbc"
SLOT="6"
DEPEND=">=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jre-1.2"
RESTRICT="fetch"

pkg_nofetch() {
	einfo
	einfo " Because of license terms and file name conventions, please:"
	einfo
	einfo " 1. Visit ${HOMEPAGE}"
	einfo "    (you may need to create an account on Oracle's site)"
	einfo " 2. Download the appropriate files:"
	einfo "    - ${file_main_orig}"
	einfo "    - ${file_rowset_orig}"
	einfo "    - ${file_nls_orig}"
	use doc > /dev/null && einfo "    - ${file_doc_orig}"
	use debug > /dev/null && einfo "    - ${file_main_debug_orig}"
	einfo " 3. Rename the files:"
	einfo "    - ${file_main_orig} --> ${file_main}"
	einfo "    - ${file_rowset_orig} --> ${file_rowset}"
	einfo "    - ${file_nls_orig} --> ${file_nls}"
	use doc > /dev/null && einfo "    - ${file_doc_orig} --> ${file_doc}"
	use debug > /dev/null && einfo "    - ${file_main_debug_orig} --> ${file_main_debug}"
	einfo " 4. Place the files in ${DISTDIR}"
	einfo " 5. Repeat the emerge process to continue."
	einfo
}

src_unpack() {
	use debug && cp ${DISTDIR}/${file_main_debug} ${S}/${file_main_debug_orig} || cp ${DISTDIR}/${file_main} ${S}/${file_main_orig}
	cp ${DISTDIR}/${file_rowset} ${S}/${file_rowset_orig}
	cp ${DISTDIR}/${file_nls} ${S}/${file_nls_orig}

	if use doc; then
		mkdir ${S}/javadoc
		cd ${S}/javadoc
		unzip ${DISTDIR}/${file_doc} || die
	fi
}

src_install() {
	if use doc ; then
		java-pkg_dohtml -r ${S}/javadoc/
	fi
	java-pkg_dojar ${S}/*.zip
}
