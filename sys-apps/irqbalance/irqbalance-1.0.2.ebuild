# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/irqbalance/irqbalance-1.0.2.ebuild,v 1.1 2011/11/05 17:59:25 vapier Exp $

EAPI="2"

DESCRIPTION="Distribute hardware interrupts across processors on a multiprocessor system"
HOMEPAGE="http://www.irqbalance.org/"
SRC_URI="http://irqbalance.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="caps numa"

RDEPEND="dev-libs/glib:2
	caps? ( sys-libs/libcap-ng )
	numa? ( sys-process/numactl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		--sbindir=/sbin \
		$(use_with caps libcap-ng) \
		$(use_enable numa)
}

src_install() {
	emake install DESTDIR="${D}" || die
	newinitd "${FILESDIR}"/irqbalance.init irqbalance || die
	newconfd "${FILESDIR}"/irqbalance.confd-1 irqbalance
}
