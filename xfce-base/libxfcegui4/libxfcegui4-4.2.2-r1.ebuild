# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfcegui4/libxfcegui4-4.2.2-r1.ebuild,v 1.15 2006/12/02 09:33:08 dev-zero Exp $

inherit xfce4 eutils

DESCRIPTION="Libraries for Xfce 4"
LICENSE="LGPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="~xfce-base/libxfce4util-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/taskbar-gtk-2.8.patch
}
