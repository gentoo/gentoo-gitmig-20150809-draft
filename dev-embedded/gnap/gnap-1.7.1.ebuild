# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gnap/gnap-1.7.1.ebuild,v 1.1 2005/06/23 13:05:26 koon Exp $

MY_P="${P/gnap/gnap-tools}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Gentoo-based Network Appliance building system"
HOMEPAGE="http://embedded.gentoo.org/gnap.xml"

SRC_URI="mirror://gentoo/${MY_P}.tar.bz2
	!minimal? ( mirror://gentoo/${PN}-core-${PV}.tar )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="minimal"

RDEPEND="app-cdr/cdrtools
	sys-fs/dosfstools
	sys-boot/syslinux"

src_unpack() {
	unpack ${MY_P}.tar.bz2
}

src_install() {
	dobin gnap_overlay
	doman gnap_overlay.1

	dodoc README.upgrading

	dodir /usr/lib/gnap
	insinto /usr/lib/gnap
	if ! use minimal; then
		newins ${DISTDIR}/${PN}-core-${PV}.tar ${PN}-core.tar
		doins -r mbr
		doins -r examples
	fi
}
