# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/emerge-delta-webrsync/emerge-delta-webrsync-3.4.ebuild,v 1.1 2005/12/26 09:10:30 ferringb Exp $

DESCRIPTION="emerge-webrsync using patches to minimize bandwidth"
HOMEPAGE="http://dev.gentoo.org/~ferringb/"
SRC_URI="http://dev.gentoo.org/~ferringb/${P}"

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
}

src_compile() { :; }

src_install() {
	newbin "${WORKDIR}/${P}" "${PN}" || die "failed copying ${P}"
	dodir /var/delta-webrsync
	fperms 0770 /var/delta-webrsync
}

pkg_preinst() {
	chgrp portage ${IMAGE}/var/delta-webrsync
}
