# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/levee/levee-3.5a.ebuild,v 1.4 2009/11/21 17:24:33 maekke Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Really tiny vi clone, for things like rescue disks"
HOMEPAGE="http://www.pell.chi.il.us/~orc/Code/"
SRC_URI="http://www.pell.chi.il.us/~orc/Code/levee/${P}.tar.gz"

LICENSE="levee"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

DEPEND="!app-text/lv
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-QA.patch
	epatch "${FILESDIR}"/${PN}-3.5-glibc210.patch
}

src_compile() {
	./configure.sh --prefix=/usr || die "configure failed"
	emake	CFLAGS="${CFLAGS} -Wall -Wextra ${LDFLAGS}" \
		CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake PREFIX="${D}" install || die "emake install failed"
}
