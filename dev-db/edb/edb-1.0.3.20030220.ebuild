# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/edb/edb-1.0.3.20030220.ebuild,v 1.1 2003/02/20 11:41:12 vapier Exp $

DESCRIPTION="Enlightment Data Base"
HOMEPAGE="http://www.enlightenment.org/pages/edb.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"
IUSE="pic ncurses gtk"

DEPEND="gtk? ( =x11-libs/gtk+-1* )
	ncurses? ( sys-libs/ncurses )"
RDEPEND="virtual/glibc"

S=${WORKDIR}/${PN}

src_compile() {
	cp autogen.sh{,.old}
	sed -e 's:.*configure.*::' autogen.sh.old > autogen.sh
	env WANT_AUTOCONF_2_5=1 ./autogen.sh || die "could not autogen"

	econf \
		`use_with pic` \
		--enable-compat185 \
		--enable-dump185 \
		--enable-cxx \
		--with-gnu-ld \
		|| die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README
}
