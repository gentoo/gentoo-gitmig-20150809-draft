# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/trayimonc/trayimonc-0.7.1.ebuild,v 1.2 2005/02/12 10:07:44 mrness Exp $

inherit kde

DESCRIPTION="TrayImonc, a KDE based imond client for fli4l"
SRC_URI="http://www.trayimonc.de/${P}${V}.tar.bz2"
HOMEPAGE="http://www.trayimonc.de/"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="xinerama debug"

need-kde 3

src_compile() {
	local myconf=""
	set-kdedir 3

	useq xinerama && \
		myconf="${myconf} --enable-Xinerama"
	useq debug && \
		myconf="${myconf} --enable-debug=full"

	econf $myconf && \
		emake || die "Compile has failed!"
}

src_install() {
	einstall || die "make install has failed"
}
