# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/sheepshaver/sheepshaver-20040319.ebuild,v 1.1 2004/03/19 15:23:43 dholm Exp $

S="${WORKDIR}/${P}/SheepShaver"
DESCRIPTION="A MacOS run-time environment that allows you to run classic MacOS applications"
HOMEPAGE="http://www.uni-mainz.de/~bauec002/SheepShaver.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE="gtk esd"

DEPEND="gtk? ( x11-libs/gtk+ )
	esd? ( media-sound/esound )"

src_compile() {
	make links || die "Failed making links"

	cd src/Unix
	aclocal; autoheader; autoconf

	econf || die "configure failed"
	emake || die "compilation failed"
}

src_install() {
	dohtml doc/Linux/*

	cd src/Unix
	einstall || die "Installation failed"
}
