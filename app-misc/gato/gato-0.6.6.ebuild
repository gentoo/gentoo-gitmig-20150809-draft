# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="An interface to the at UNIX command"
HOMEPAGE="http://www.arquired.es/users/aldelgado/proy/gato/"
SRC_URI="http://www.arquired.es/users/aldelgado/proy/gato/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="=x11-libs/gtk+-1*"
DEPEND="${RDEPEND}
	sys-devel/automake
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	aclocal && autoheader && automake -a --foreign && autoconf || die "autotools failed"
}

src_compile() {
	cd src
	econf || die
	emake || die
}

src_install() {
	make install.xpm PREFIX="${D}/usr" || die "install.xpm failed"
	dodoc AUTHOR CHANGELOG README TODO
	cd src
	make install DESTDIR="${D}" || die "install failed"
}
