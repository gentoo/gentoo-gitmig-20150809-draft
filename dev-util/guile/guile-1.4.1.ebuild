# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/guile/guile-1.4.1.ebuild,v 1.1 2002/08/19 06:47:14 leonardop Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Guile is an interpreter for Scheme"
SRC_URI="mirror://gnu/guile/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/guile/"

SLOT="1.4"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/readline-4.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp  ${FILESDIR}/net_db.c libguile/
}

src_compile() {

	econf \
		--with-threads \
		--with-modules || die "Configuration failed"

	make || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"

	dodoc ANON-CVS AUTHORS COPYING ChangeLog HACKING NEWS README
	dodoc SNAPSHOTS THANKS
}
