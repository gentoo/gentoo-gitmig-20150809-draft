# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/links/links-0.96-r2.ebuild,v 1.4 2002/08/29 22:42:37 seemant Exp $

S=${WORKDIR}/${P}
SRC_URI="http://artax.karlin.mff.cuni.cz/~mikulas/links/download/${P}.tar.gz"
HOMEPAGE="http://artax.karlin.mff.cuni.cz/~mikulas/links"
DESCRIPTION="A console-based web browser"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=sys-libs/ncurses-5.1
	gpm? ( >=sys-libs/gpm-1.19.3 )
	ssl? ( >=dev-libs/openssl-0.9.6 )"

PROVIDE="virtual/textbrowser"

src_unpack() {

	unpack ${A}

	cd ${S}
	# patch to add gpm configure switch it solves the linking problem
	# when USE="-gpm" is specified but gpm is installed
	patch -p0 < ${FILESDIR}/${PF}-gentoo.patch || die

	autoheader
	aclocal
	automake
	autoconf
}

src_compile() {
	local myconf
	use ssl \
		&& myconf="--with-ssl" \
		|| myconf="--without-ssl"
	use gpm \
		&& myconf="${myconf} --with-gpm" \
		|| myconf="${myconf} --without-gpm"

	econf ${myconf} || die

	emake || die
}


src_install() {
    einstall
	dodoc README SITES NEWS AUTHORS COPYING BUGS TODO Changelog
}
