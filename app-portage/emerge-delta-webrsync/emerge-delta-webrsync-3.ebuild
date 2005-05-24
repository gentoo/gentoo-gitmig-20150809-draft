# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/emerge-delta-webrsync/emerge-delta-webrsync-3.ebuild,v 1.2 2005/05/24 12:45:01 ferringb Exp $

DESCRIPTION="emerge-webrsync using patches to minimize bandwidth"
HOMEPAGE="http://dev.gentoo.org/~ferringb/"
SRC_URI="http://dev.gentoo.org/~ferringb/${P}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/portage
	>=dev-util/diffball-0.6.5"

src_unpack() { :; }

src_compile() { :; }

src_install() {
	newbin ${DISTDIR}/${P} ${PN} || die "failed copying ${P}"
	dodir /var/delta-webrsync
	fowners root:portage /var/delta-webrsync
	fperms 0770 /var/delta-webrsync
}
