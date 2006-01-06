# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwdata-gentoo/hwdata-gentoo-0.2.ebuild,v 1.3 2006/01/06 15:22:50 gustavoz Exp $

inherit eutils

DESCRIPTION="Data for the hwsetup program"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~wolf31o2/sources/hwdata-gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.gentoo.org"

IUSE="opengl livecd"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ppc64 sparc x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="!sys-apps/hwdata
	!sys-apps/hwdata-knoppix"

src_unpack() {
	unpack ${A}
	if use x86
	then
		if use livecd && use opengl
		then
			epatch ${FILESDIR}/fglrx.patch || die "patching for ATI"
			epatch ${FILESDIR}/nvidia.patch || die "patching for nVidia"
		fi
	elif use amd64
	then
		if use livecd && use opengl
		then
			epatch ${FILESDIR}/nvidia.patch || die "patching for nVidia"
		fi
	fi
}

src_install() {
	dodoc ChangeLog check-cards
	insinto /usr/share/hwdata
	doins Cards MonitorsDB pcitable blacklist
}
