# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/linuxtrade/linuxtrade-3.65.ebuild,v 1.2 2004/07/20 00:54:27 agriffis Exp $

inherit eutils

DESCRIPTION="real-time stock market tracker and news console"
HOMEPAGE="http://linuxtrade.rkkda.com/"
SRC_URI="mirror://debian/pool/main/l/${PN}/${P/-/_}.orig.tar.gz
	mirror://debian/pool/main/l/${PN}/${P/-/_}-5.diff.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd ${S} || die

	# This package is no longer open source so won't be releasing any
	# updated versions.  Might as well use the Debian patches in that
	# case.
	epatch ${DISTDIR}/${P/-/_}-5.diff.gz

	# Don't use reserved word "bool" as a variable
	epatch ${FILESDIR}/${PN}-3.65-bool.patch
}

src_install() {
	einstall || die

	# This package gets a little overeager installing desktop files.
	# Just keep the one in /usr/share/applications and the icon in
	# /usr/share/pixmaps
	rm -r ${D}/usr/share/{gnome,applnk,icons}
}
