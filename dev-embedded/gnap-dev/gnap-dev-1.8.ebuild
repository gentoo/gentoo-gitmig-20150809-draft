# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gnap-dev/gnap-dev-1.8.ebuild,v 1.1 2005/08/10 11:25:00 koon Exp $

MY_P=${P/gnap-dev/gnap-sources}
S="${WORKDIR}/gnap-${PV}"
DESCRIPTION="Gentoo-based Network Appliance building system development tools"
HOMEPAGE="http://embedded.gentoo.org/gnap.xml"

SRC_URI="mirror://gentoo/${MY_P}.tar.bz2
	!minimal? (	mirror://gentoo/gnap-stageseed-${PV}.tar.bz2
		mirror://gentoo/gnap-portagesnapshot-${PV}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="minimal"

RDEPEND="dev-util/catalyst
	sys-fs/squashfs-tools
	app-cdr/cdrtools"

src_unpack() {
	unpack ${MY_P}.tar.bz2
}

src_install() {
	dobin gnap_make
	doman gnap_make.1

	dodir /usr/lib/gnap
	insinto /usr/lib/gnap
	doins -r specs
	if ! use minimal; then
		newins ${DISTDIR}/gnap-stageseed-${PV}.tar.bz2 gnap-stage3seed.tar.bz2
		newins ${DISTDIR}/gnap-portagesnapshot-${PV}.tar.bz2 gnap-portagesnapshot.tar.bz2
	fi
}
