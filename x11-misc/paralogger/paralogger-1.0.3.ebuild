# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/paralogger/paralogger-1.0.3.ebuild,v 1.1 2003/12/26 00:56:16 pyrania Exp $

DESCRIPTION="Bourne shell script to "tail" the system log(s) in borderless transparent Eterm(s)"
HOMEPAGE="http://projects.gtk.mine.nu/paralogger"

SRC_URI="http://freshmeat.net/redir/paralogger/12441/url_tgz/paralogger-1.0.3.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND="x11-terms/eterm
	app-misc/colortail"

src_compile() {
	econf
}

src_install() {
	exeinto /usr/bin
	doexe paralogger
	doexe paracal
	dodir /etc/paralogger
	insinto /etc/paralogger
	doins etc/paralogger/*
	dodir /usr/X11R6/lib/X11/fonts/misc
	insinto /usr/X11R6/lib/X11/fonts/misc
	doins fonts/*pcf.gz
	doman paralogger.1.gz
	dodoc README INSTALL AUTHORS BUGS ChangeLog FAQ THANKS TODO REPORTING-BUGS
}
