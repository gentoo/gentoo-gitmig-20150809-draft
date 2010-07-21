# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdotool/xdotool-20090609.ebuild,v 1.5 2010/07/21 15:17:45 ssuominen Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Simulate keyboard input and mouse activity, move and resize windows."
HOMEPAGE="http://www.semicomplete.com/projects/xdotool/"
SRC_URI="http://semicomplete.googlecode.com/files/${P}.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples"

DEPEND="x11-libs/libXtst
	x11-libs/libX11"

RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "s:^CFLAGS=.*:CFLAGS=-std=c99 ${CFLAGS}:" \
		-e "s:^LIBS=.*:LIBS=$(pkg-config --libs x11 xtst):" \
		-e "s:^INC=.*:INC=$(pkg-config --cflags x11 xtst):" \
		-e "s:\$(CC):$(tc-getCC):" \
		-e 's:LDFLAGS+=$(LIBS)::' \
		-e 's:-o $@:$(LIBS) -o $@:' \
		-e "s:\$(CFLAGS):\$(INC) \$(CFLAGS):" \
		Makefile \
		|| die "sed Makefile failed."
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc CHANGELIST README
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
