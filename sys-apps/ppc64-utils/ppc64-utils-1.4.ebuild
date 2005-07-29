# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ppc64-utils/ppc64-utils-1.4.ebuild,v 1.2 2005/07/29 19:17:48 dostrow Exp $

DESCRIPTION="Utilities for maintaining and servicing IBM PPC64 systems:
accessing NVRAM, flashing firmware, start/stopping virtual IO servers, etc."
HOMEPAGE="http://techsupport.services.ibm.com/server/lopdiags"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="-* ppc64"
IUSE=""

src_install() {
	make DESTDIR="${D}" install

	#install doc
	dodoc COPYRIGHT README
}
