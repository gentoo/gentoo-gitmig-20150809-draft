# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/kissme/kissme-0.0.32.ebuild,v 1.1 2004/04/06 02:03:22 zx Exp $

DESCRIPTION="Tiny, JITless JVM"
SRC_URI="mirror://sourceforge/kissme/${P}.tar.gz"
HOMEPAGE="http://kissme.sourceforge.net/"
DEPEND="virtual/glibc
		virtual/x11
		>=dev-libs/gmp-3.1.1
		>=dev-java/jikes-1.19
		>=dev-java/gnu-classpath-0.08_rc1"
RDEPEND=""
IUSE="doc"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	econf \
		--with-java-compiler=/usr/bin/jikes || die "conf failed"
	emake || die "make failed"
}

src_install () {
	einstall || die "install failed"
	dodoc AUTHORS COPYING NEWS
	dodoc doc/*.txt
	dodoc doc/{TAGS,TIMING}
	use doc && dohtml -r doc/*
	exeinto /usr/bin
	newexe ${FILESDIR}/kissme.sh kissme
}
