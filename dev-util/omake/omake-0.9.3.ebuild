# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/omake/omake-0.9.3.ebuild,v 1.1 2004/10/19 07:48:37 mattam Exp $

EXTRAPV="-2"
DESCRIPTION="Make replacement"
HOMEPAGE="http://omake.metaprl.org/"
SRC_URI="http://omake.metaprl.org/downloads/${P}${EXTRAPV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="fam ncurses readline"
DEPEND=">=dev-lang/ocaml-3.0.8
	fam? ( >=app-admin/fam-2.7.0 )
	ncurses? ( >=sys-libs/ncurses-5.3 )
	readline? ( >=sys-libs/readline-5.0 )"

src_compile() {
	./configure \
		`use_with ncurses` \
		`use_with readline` \
		`use_with fam` \
		--prefix=/usr \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	make libdir=${D}/usr/lib \
		mandir=${D}/usr/share/man \
		bindir=${D}/usr/bin \
		install || die
}
