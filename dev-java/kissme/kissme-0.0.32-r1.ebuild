# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/kissme/kissme-0.0.32-r1.ebuild,v 1.1 2004/07/31 21:50:35 karltk Exp $

inherit java-pkg

DESCRIPTION="Tiny, JITless JVM"
SRC_URI="mirror://sourceforge/kissme/${P}.tar.gz"
HOMEPAGE="http://kissme.sourceforge.net/"
DEPEND="virtual/libc
		virtual/x11
		>=dev-libs/gmp-3.1.1
		>=dev-java/jikes-1.19
		>=dev-java/gnu-classpath-0.08_rc1"
RDEPEND=""
IUSE="doc jikes"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_compile() {

	# 2004-07-31: karltk
	# Will only compile with jikes		  

	econf --with-java-compiler=/usr/bin/jikes || die "conf failed"
	emake all classes.zip || die "make failed"
}

src_install () {
	einstall || die "install failed"

	dodoc AUTHORS COPYING NEWS ChangeLog

	java-pkg_dojar classes.zip

	exeinto /usr/bin
	newexe ${FILESDIR}/kissme.sh kissme
}
