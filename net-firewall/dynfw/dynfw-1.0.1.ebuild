# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/dynfw/dynfw-1.0.1.ebuild,v 1.5 2004/03/20 07:34:37 mr_bones_ Exp $

DESCRIPTION="Dynamic Firewall Tools for netfilter-based firewalls"
SRC_URI="http://gentoo.org/projects/${P}.tar.gz"
HOMEPAGE="http://gentoo.org/projects/dynfw"

KEYWORDS="x86 sparc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="app-shells/bash"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:##PREFIX##:/usr:g" \
			ipblock ipdrop tcplimit host-tcplimit user-outblock || \
				die "sed PREFIX failed"
}

src_install () {
	dosbin ipblock ipdrop tcplimit host-tcplimit user-outblock || \
		die "dosbin failed"

	insinto /usr/share
	insopts "-m0755"
	doins dynfw.sh || die "doins failed"
}
