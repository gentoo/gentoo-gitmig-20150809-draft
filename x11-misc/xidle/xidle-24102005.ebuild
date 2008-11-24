# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xidle/xidle-24102005.ebuild,v 1.2 2008/11/24 09:15:43 flameeyes Exp $

inherit eutils toolchain-funcs

DESCRIPTION="xidle monitors inactivity in X and runs the specified program when
a timeout occurs."
HOMEPAGE="http://www.freebsdsoftware.org/x11/xidle.html"
SRC_URI="mirror://freebsd/ports/local-distfiles/novel/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~hppa ~x86"
IUSE=""

DEPEND="
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXScrnSaver
	"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-dead.patch"
}

src_compile() {
	local my_libs="-lXss -lXext -lX11"
	local my_compile
	my_compile="$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o ${PN}{,.c} ${my_libs}"
	echo ${my_compile}
	eval ${my_compile} || die "compile failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	doman ${PN}.1 || die "doman failed"
}
