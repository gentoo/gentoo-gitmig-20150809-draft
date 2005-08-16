# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mkxf86config/mkxf86config-0.9.1.ebuild,v 1.2 2005/08/16 21:02:07 wolf31o2 Exp $

inherit eutils

IUSE=""

DESCRIPTION="xorg-x11 configuration builder for Gentoo"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gentoo.org"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=""
RDEPEND="sys-apps/hwsetup
	sys-apps/ddcxinfo-knoppix
	virtual/libc"

src_install() {
	insinto /etc/X11
	doins xorg.conf.in
	exeinto /usr/sbin
	doexe mkxf86config.sh
	newinitd ${FILESDIR}/mkxf86config-init mkxf86config
}
