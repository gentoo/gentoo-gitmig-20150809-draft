# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# 

KEYWORDS="~x86"
S="${WORKDIR}/${PN}"
DESCRIPTION="A Kanji code converter"
SRC_URI="ftp://ftp.jp.freebsd.org/pub/FreeBSD/ports/distfiles/${PN}.tar.gz"
HOMEPAGE=""  	#There doesn't seem to be a home page for this package!
LICENSE="GPL2"

DEPEND="virtual/glibc"

SLOT=0

src_unpack() {

	# unpack the archive
	unpack ${A}

	cd ${S}
	patch -p0 < ${FILESDIR}/${P}/gentoo.diff || die
}

src_compile() {
	make
}

src_install () {

	# install libs, executables, dictionaries
	make DESTDIR=${D} install     || die "installation failed"

	# install docs
	dodoc README
}
