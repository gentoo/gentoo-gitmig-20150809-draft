# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/emerge-delta-webrsync/emerge-delta-webrsync-3.5.1-r1.ebuild,v 1.1 2006/10/14 15:45:23 betelgeuse Exp $

inherit eutils

DESCRIPTION="emerge-webrsync using patches to minimize bandwidth"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/index.xml"
SRC_URI="mirror://gentoo/${P}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/portage
	>=dev-util/diffball-0.6.5
	x86? ( app-arch/tarsync )"

src_unpack() {
	cp "${DISTDIR}/${P}" "${WORKDIR}/" || die "failed cping $P"
	epatch "${FILESDIR}/${PV}-metadata.patch"
	epatch "${FILESDIR}/${PV}-md5sum.patch"
}

src_compile() { :; }

src_install() {
	newbin "${WORKDIR}/${P}" "${PN}" || die "failed copying ${P}"
	keepdir /var/delta-webrsync
	fperms 0770 /var/delta-webrsync
}

pkg_preinst() {
	chgrp portage ${IMAGE}/var/delta-webrsync
}
