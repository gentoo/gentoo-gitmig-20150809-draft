# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/emerge-delta-webrsync/emerge-delta-webrsync-1.ebuild,v 1.1 2005/04/18 04:01:42 ferringb Exp $


DESCRIPTION="emerge-webrsync using patches to minimize bandwidth"
HOMEPAGE="dev.gentoo.org/~ferringb/"
SRC_URI="http://dev.gentoo.org/~ferringb/${P}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS='~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64 ~ppc-macos'

RDEPEND="sys-apps/portage >=dev-util/diffball-0.6.5"

src_unpack() { :; }

src_install() {
	insinto /usr/bin
	newins ${DISTDIR}/${P} "${P%-*}" || die "failed copying ${P}"
}
