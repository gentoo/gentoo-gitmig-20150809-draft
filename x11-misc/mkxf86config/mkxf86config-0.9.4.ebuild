# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mkxf86config/mkxf86config-0.9.4.ebuild,v 1.2 2006/06/09 01:12:57 wolf31o2 Exp $

inherit eutils

DESCRIPTION="xorg-x11 configuration builder for Gentoo"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gentoo.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="sys-apps/hwsetup"

src_install() {
	insinto /etc/X11
	doins xorg.conf.in
	exeinto /usr/sbin
	doexe mkxf86config.sh
	newinitd ${FILESDIR}/mkxf86config-init mkxf86config
}
