# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwdata-gentoo/hwdata-gentoo-0.4.ebuild,v 1.2 2008/04/10 06:33:32 wolf31o2 Exp $

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
	!sys-apps/hwdata-knoppix
	!sys-apps/hwdata-redhat"

src_unpack() {
	unpack ${A}
	if use x86 || use amd64
	then
		if use opengl && use binary-drivers
		then
			continue
		else
			sed -e 's/DRIVER fglrx/DRIVER radeon/' \
				-e 's/DRIVER nvidia/DRIVER nv/' \
				-i "${S}"/Cards || die
		fi
	fi
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-openchrome.patch
}

src_install() {
	dodoc ChangeLog check-cards
	insinto /usr/share/hwdata
	doins Cards MonitorsDB pcitable blacklist
}
