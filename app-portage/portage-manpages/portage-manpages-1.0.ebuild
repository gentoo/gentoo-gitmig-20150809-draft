# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portage-manpages/portage-manpages-1.0.ebuild,v 1.3 2005/01/01 15:54:28 eradicator Exp $

DESCRIPTION="collection of Gentoo manpages"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/man"

S=${WORKDIR}/man

src_install() {
	doman * || die
}
