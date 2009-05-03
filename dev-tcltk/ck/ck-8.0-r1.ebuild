# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/ck/ck-8.0-r1.ebuild,v 1.1 2009/05/03 19:24:53 mescalinum Exp $

EAPI=2

MY_P=${PN}${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A curses based toolkit for tcl"
HOMEPAGE="http://www.ch-werner.de/ck/"
SRC_URI="http://www.ch-werner.de/ck/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=dev-lang/tk-8.0"
RDEPEND="${DEPEND}"

src_prepare() {
	# patch Makefile
	sed -i \
		-e "s:mkdir:mkdir -p:g" \
		-e "s|install: |install: install-man |" \
		-e 's:^.*\(MAN_INSTALL_DIR\).*=.*$:\1 = $(INSTALL_ROOT)$(prefix)/share/man:g' \
		Makefile.in
}

src_configure() {
	econf --with-tcl=/usr/lib --enable-shared || die "econf failed"
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc README
	einstall || die "Failed to install."
}
