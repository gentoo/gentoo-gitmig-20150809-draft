# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gnap-dev/gnap-dev-1.6.ebuild,v 1.1 2005/05/17 12:30:39 koon Exp $

STAGE2_VERSION="x86-uclibc-hardened-2005.0"

MY_P=${P/gnap-dev/gnap-sources}
S="${WORKDIR}/gnap-${PV}"
DESCRIPTION="GNAP is a Gentoo-based Network Appliance building system. The gnap-dev package contains the GNAP development environment allowing to rebuild GNAP core files from scratch."
HOMEPAGE="http://embedded.gentoo.org/gnap.xml"

SRC_URI="mirror://gentoo/${MY_P}.tar.bz2
	!minimal? (	http://gentoo.osuosl.org/experimental/x86/embedded/stages/stage2-${STAGE2_VERSION}.tar.bz2 )"

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
		newins ${DISTDIR}/stage2-${STAGE2_VERSION}.tar.bz2 stage2seed.tar.bz2
	fi
}
