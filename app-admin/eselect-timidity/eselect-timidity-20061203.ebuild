# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-timidity/eselect-timidity-20061203.ebuild,v 1.7 2007/02/06 13:33:31 blubb Exp $

DESCRIPTION="Manages configuration of TiMidity++ patchsets"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/timidity.eselect-${PVR}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0.2"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${WORKDIR}/timidity.eselect-${PVR}" timidity.eselect || die
}
