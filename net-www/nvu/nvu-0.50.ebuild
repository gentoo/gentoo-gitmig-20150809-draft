# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/nvu/nvu-0.50.ebuild,v 1.1 2004/10/14 23:17:00 chriswhite Exp $

inherit eutils mozilla flag-o-matic

DESCRIPTION="A WYSIWG web editor for linux similiar to Dreamweaver"
HOMEPAGE="http://www.nvu.com/"
SRC_URI="http://cvs.nvu.com/download/${P}-sources.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE="kde gnome"
DEPEND="sys-apps/gawk
		dev-lang/perl
		app-doc/doxygen"

S=${WORKDIR}/mozilla

src_compile() {

	# I had to manually edit the mozconfig.linux file as it
	# has some quirks... just copy the darn thing over :) - Chris
	cp ${FILESDIR}/.mozconfig ${S}

	# It "sort of" has a standard configure system
	# Here's how I fix the prefix issue. - Chris
	epatch ${FILESDIR}/${P}-prefix.patch

	# The build system is a weeee bit sensitive to naughty -O flags.
	# filter them out and let the build system figure out what
	# won't let it die :) - Chris
	filter-flags '-O*'

	make -f client.mk build_all
}

src_install() {
	make -f client.mk DESTDIR=${D} install || die

	#menu entry for gnome
	if use gnome
	then
		insinto /usr/share/gnome/apps/Applications
		doins ${FILESDIR}/nvu.desktop
	fi

	#menu entry for kde
	if use kde
	then
		insinto /usr/share/applnk/Development
		doins ${FILESDIR}/nvu.desktop
	fi
}
