# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwdata-gentoo/hwdata-gentoo-0.3.ebuild,v 1.3 2006/09/01 23:09:44 wolf31o2 Exp $

inherit eutils

DESCRIPTION="Data for the hwsetup program"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~wolf31o2/sources/hwdata-gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.gentoo.org"

IUSE="opengl binary-drivers"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="!sys-apps/hwdata
	!sys-apps/hwdata-knoppix"

src_unpack() {
	unpack ${A}
	if use x86 || use amd64
	then
		if use opengl && use binary-drivers
		then
			epatch "${FILESDIR}"/${PV}-fglrx.patch || die "patching for ATI"
			epatch "${FILESDIR}"/${PV}-nvidia.patch || die "patching for nVidia"
		else
			# On amd64/x86, we choose VESA over fbdev
			epatch "${FILESDIR}"/${PV}-nv-vesa.patch || die "patching vesa"
		fi
	else
		# The "nv" driver sucks so much, we choose fbdev, instead
		epatch "${FILESDIR}"/${PV}-nv-fbdev.patch || die "patching fbdev"
	fi
}

src_install() {
	dodoc ChangeLog check-cards
	insinto /usr/share/hwdata
	doins Cards MonitorsDB pcitable blacklist
}
