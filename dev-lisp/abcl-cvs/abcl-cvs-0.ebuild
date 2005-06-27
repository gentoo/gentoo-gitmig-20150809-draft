# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/abcl-cvs/abcl-cvs-0.ebuild,v 1.3 2005/06/27 21:59:02 mkennedy Exp $

ECVS_SERVER="cvs.sourceforge.net:/cvsroot/armedbear-j"
if [ -z "${ECVS_BRANCH}" ]; then
	ECVS_BRANCH="HEAD"
fi
ECVS_MODULE="j"
ECVS_USER="anonymous"
ECVS_PASS=""
ECVS_CVS_OPTIONS="-dP"

inherit cvs java-pkg eutils

DESCRIPTION="Armed Bear Common Lisp is a Common Lisp implementation for the JVM."
HOMEPAGE="http://armedbear-j.sourceforge.net/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug libabcl jpty"

DEPEND="virtual/jdk"

S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	chmod +x ${S}/{configure,mkinstalldirs}
	econf --with-jdk=`java-config -O` \
		`use_enable debug debug` \
		`use_enable libabcl libabcl` \
		`use_enable jpty jpty` \
		|| die
	make || die
}

src_install() {
	find ${S} -type d -name CVS -exec rm -rf '{}' \;
	java-pkg_dojar j.jar
	dohtml doc/*
	insinto /usr/share/j
	doins -r themes
	dobin ${FILESDIR}/{abcl,j}
	if use jpty; then
		dobin src/jpty/jpty
	fi
	if use libabcl; then
		exeinto /usr/$(get_libdir)/abcl
		doexe src/org/armedbear/lisp/libabcl.so
	fi
}
