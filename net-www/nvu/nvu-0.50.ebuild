# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/nvu/nvu-0.50.ebuild,v 1.6 2004/10/18 03:34:29 weeve Exp $

inherit eutils mozilla flag-o-matic

DESCRIPTION="A WYSIWG web editor for linux similiar to Dreamweaver"
HOMEPAGE="http://www.nvu.com/"
SRC_URI="http://cvs.nvu.com/download/${P}-sources.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""
DEPEND="sys-apps/gawk
		dev-lang/perl
		app-doc/doxygen"

S=${WORKDIR}/mozilla

src_compile() {

	# I had to manually edit the mozconfig.linux file as it
	# has some quirks... just copy the darn thing over :) - Chris
	cp ${FILESDIR}/mozconfig ${S}/.mozconfig

	# Fix those darn directories!  Make something more "standard"
	# That can extend to future versions with much more ease. - Chris
	epatch ${FILESDIR}/${P}-dir.patch

	# The build system is a weeee bit sensitive to naughty -O flags.
	# filter them out and let the build system figure out what
	# won't let it die :) - Chris
	filter-flags '-O*'

	make -f client.mk build_all
}

src_install() {

	# patch the final nvu binary to workaround bug #67658
	epatch ${FILESDIR}/${P}-nvu.patch

	make -f client.mk DESTDIR=${D} install || die

	#menu entry for gnome/kde
	insinto /usr/share/applications
	doins ${FILESDIR}/nvu.desktop
}
