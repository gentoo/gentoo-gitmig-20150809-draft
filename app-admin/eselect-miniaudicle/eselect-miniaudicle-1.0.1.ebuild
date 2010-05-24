# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-miniaudicle/eselect-miniaudicle-1.0.1.ebuild,v 1.3 2010/05/24 15:18:38 phajdan.jr Exp $

DESCRIPTION="Manages the /usr/bin/miniAudicle symlink"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/miniaudicle.eselect-${PVR}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-admin/eselect-1.2.3"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${WORKDIR}/miniaudicle.eselect-${PVR}" miniaudicle.eselect || die
}
