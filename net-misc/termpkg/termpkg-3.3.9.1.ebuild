# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/termpkg/termpkg-3.3.9.1.ebuild,v 1.1 2008/09/23 19:34:00 sbriesen Exp $

inherit eutils versionator

MY_PV=$(get_version_component_range 1-2)
MY_PF=$(replace_version_separator 2 '-')

DESCRIPTION="Termpkg, the Poor Man's Terminal Server"
HOMEPAGE="http://www.linuxlots.com/~termpkg/"
SRC_URI="mirror://debian/pool/main/t/termpkg/${PN}_${MY_PV}.orig.tar.gz
	mirror://debian/pool/main/t/termpkg/${PN}_${MY_PF}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="uucp"

DEPEND="sys-devel/flex"
RDEPEND="sys-process/procps"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# apply debian patches
	epatch "${WORKDIR}/${PN}_${MY_PF}.diff"

	# apply gentoo patches
	epatch "${FILESDIR}/${P}-gcc43.diff"

	# apply iaxmodem patches
	epatch "${FILESDIR}/${PN}-${MY_PV}-ttydforfax.diff"
}

src_compile() {
	./configure LINUX $(use uucp && echo UUCP_LOCKING)
	emake -C linux CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	dobin linux/bin/termnet
	dosbin linux/bin/{termnetd,ttyd}
	dodoc CHANGES README termpkg.lsm
	newdoc debian/changelog ChangeLog.debian
	doman doc/*.1
	insinto /etc
	newins debian/termnetd.conf termnetd.conf.dist
	for X in termnetd ttyd; do
		newinitd "${FILESDIR}/${X}.initd" "${X}"
		newconfd "${FILESDIR}/${X}.confd" "${X}"
	done
}
