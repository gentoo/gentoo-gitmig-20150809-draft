# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/reed/reed-5.4.ebuild,v 1.11 2009/01/27 09:11:18 pva Exp $

inherit toolchain-funcs

DESCRIPTION="This is a text pager (text file viewer), used to display etexts."
# Homepage http://www.sacredchao.net/software/reed/index.shtml does not exist.
HOMEPAGE="http://web.archive.org/web/20040217010815/www.sacredchao.net/software/reed/"
SRC_URI="http://www.sacredchao.net/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -e "s:-O2:${CFLAGS} ${LDFLAGS}:" \
		-e "s: wrap::" \
		-e "s:-s reed:reed:" -i Makefile.in
	rm wrap.1 # Collision with talkfilters, bug #247396
}

src_compile() {
	./configures --prefix=/usr || die "configures failed"
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc AUTHORS BUGS NEWS README
}
