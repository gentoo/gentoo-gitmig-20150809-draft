# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dialog/dialog-1.0.20050206.ebuild,v 1.4 2005/04/09 00:50:56 gustavoz Exp $

inherit eutils

MY_PV="${PV/1.0./1.0-}"
S=${WORKDIR}/${PN}-${MY_PV}
DESCRIPTION="tool to display dialog boxes from a shell"
HOMEPAGE="http://hightek.org/dialog/"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${MY_PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 ~ppc-macos s390 sh sparc x86"
IUSE="unicode"

DEPEND=">=app-shells/bash-2.04-r3
	>=sys-libs/ncurses-5.2-r5"

src_compile() {
	#export LANG=C
	use unicode && ncursesw="w"
	econf "--with-ncurses${ncursesw}" || die "configure failed"
	emake || die "build failed"
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc CHANGES README VERSION

	docinto samples
	dodoc samples/*
	docinto samples/install
	dodoc samples/install/*
	docinto samples/copifuncs
	dodoc samples/copifuncs/*
}
