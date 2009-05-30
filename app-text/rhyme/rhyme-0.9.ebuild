# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rhyme/rhyme-0.9.ebuild,v 1.11 2009/05/30 02:07:14 darkside Exp $

inherit toolchain-funcs

DESCRIPTION="Console based Rhyming Dictionary"
HOMEPAGE="http://rhyme.sourceforge.net/"
SRC_URI="mirror://sourceforge/rhyme/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.3
	>=sys-libs/readline-4.3
	>=sys-libs/gdbm-1.8.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# termcap is used by default, switch to ncurses
	sed -i 's/-ltermcap/-lncurses/g' "${S}"/Makefile
}

src_compile() {
	# Disable parallell building wrt bug #125967
	emake -j1 CC="$(tc-getCC)" FLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	# author doesnt use -D for install
	dodir /usr/share/rhyme /usr/bin /usr/share/man/man1

	einstall BINPATH="${D}"/usr/bin \
			MANPATH="${D}"/usr/share/man/man1 \
			RHYMEPATH="${D}"/usr/share/rhyme
}
