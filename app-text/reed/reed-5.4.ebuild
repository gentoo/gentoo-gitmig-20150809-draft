# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/reed/reed-5.4.ebuild,v 1.9 2008/12/30 21:29:30 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="This is a text pager (text file viewer), used to display etexts."
HOMEPAGE="http://www.sacredchao.net/software/reed/index.shtml"
SRC_URI="http://www.sacredchao.net/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	sed -i -e "s:-O2:${CFLAGS}:" \
		-e "s:-s::" "${S}"/Makefile.in
}

src_compile() {
	./configures --prefix=/usr || die "configures failed"
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc AUTHORS BUGS NEWS README
}
