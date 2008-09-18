# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-python/eselect-python-20080630.ebuild,v 1.1 2008/09/18 19:22:26 hawking Exp $

DESCRIPTION="Manages multiple Python versions"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/python.eselect-${PVR}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0.2"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${WORKDIR}/python.eselect-${PVR}" python.eselect || die
}
