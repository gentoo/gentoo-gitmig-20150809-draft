# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/links/links-0.96-r2.ebuild,v 1.1 2002/07/22 18:08:48 naz Exp $

S=${WORKDIR}/${P}
SRC_URI="http://artax.karlin.mff.cuni.cz/~mikulas/links/download/${P}.tar.gz"
HOMEPAGE="http://artax.karlin.mff.cuni.cz/~mikulas/links"
DESCRIPTION="A console-based web browser"
DEPEND=">=sys-libs/ncurses-5.1
	gpm? ( >=sys-libs/gpm-1.19.3 )
	ssl? ( >=dev-libs/openssl-0.9.6 )"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ppc"

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
