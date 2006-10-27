# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-whois/eselect-whois-1.0.0.ebuild,v 1.2 2006/10/27 16:59:37 flameeyes Exp $

DESCRIPTION="Manages the /usr/bin/whois symlink."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/whois.eselect-${PVR}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0.6
	!<net-misc/whois-4.7.19-r1"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${WORKDIR}"/whois.eselect-${PVR} whois.eselect
}
