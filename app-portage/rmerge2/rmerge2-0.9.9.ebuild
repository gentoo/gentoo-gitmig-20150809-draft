# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/rmerge2/rmerge2-0.9.9.ebuild,v 1.4 2004/07/13 20:22:37 agriffis Exp $

DESCRIPTION="robust version of 'emerge --emptytree' which supports resumption/forcing of builds"
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha"
IUSE=""

DEPEND="sys-apps/portage"

src_install() {
	insinto /usr/bin
	insopts -m755
	newins ${FILESDIR}/${PF} rmerge2
	dodir /var/lib/rmerge2
}
