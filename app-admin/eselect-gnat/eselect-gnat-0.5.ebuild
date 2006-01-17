# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-gnat/eselect-gnat-0.5.ebuild,v 1.1 2006/01/17 15:18:52 george Exp $

inherit eutils

DESCRIPTION="gnat module for eselect."
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="app-admin/eselect"

src_install() {
	dodir /usr/share/eselect/modules
	insinto /usr/share/eselect/modules
	doins ${FILESDIR}/gnat.eselect
}
