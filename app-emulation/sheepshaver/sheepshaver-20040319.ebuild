# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/sheepshaver/sheepshaver-20040319.ebuild,v 1.2 2004/06/02 11:53:42 dholm Exp $

inherit eutils

S="${WORKDIR}/${P}/SheepShaver"
DESCRIPTION="A MacOS run-time environment that allows you to run classic MacOS applications"
HOMEPAGE="http://www.uni-mainz.de/~bauec002/SheepShaver.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE="gtk esd"

DEPEND="gtk? ( x11-libs/gtk+ )
	esd? ( media-sound/esound )
	>=sys-devel/autoconf-2.54
	>=sys-devel/automake-1.7"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}_x86_fpu_opts.patch
}

src_compile() {
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7

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
