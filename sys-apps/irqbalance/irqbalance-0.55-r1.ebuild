# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/irqbalance/irqbalance-0.55-r1.ebuild,v 1.1 2007/08/25 18:06:58 vapier Exp $

inherit eutils

DESCRIPTION="Distribute hardware interrupts across processors on a multiprocessor system"
HOMEPAGE="http://www.irqbalance.org/"
SRC_URI="http://www.irqbalance.org/releases/${P}.tar.gz"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="=dev-libs/glib-2*"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	into /
	dosbin irqbalance || die "dosbin failed"
	doman "${FILESDIR}"/irqbalance.1
	newinitd "${FILESDIR}"/irqbalance.init irqbalance
	newconfd "${FILESDIR}"/irqbalance.confd irqbalance
}
