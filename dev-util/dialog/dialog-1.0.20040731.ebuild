# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dialog/dialog-1.0.20040731.ebuild,v 1.6 2004/11/01 17:31:44 gustavoz Exp $

inherit eutils

MY_PV="${PV/1.0./1.0-}"
S=${WORKDIR}/${PN}-${MY_PV}
DESCRIPTION="tool to display dialog boxes from a shell"
HOMEPAGE="http://hightek.org/dialog/"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${MY_PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390 ~ppc-macos"
IUSE="unicode"

DEPEND=">=app-shells/bash-2.04-r3
	>=sys-libs/ncurses-5.2-r5"

src_compile() {
	export LANG=C
	use unicode && ncursesw="w"
	econf "--with-ncurses${ncursesw}" || die "configure failed"
	emake || die "build failed"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc CHANGES README VERSION

	docinto samples
	dodoc samples/*
	docinto samples/install
	dodoc samples/install/*
	docinto samples/copifuncs
	dodoc samples/copifuncs/*
}
