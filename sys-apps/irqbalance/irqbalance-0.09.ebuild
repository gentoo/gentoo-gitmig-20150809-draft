# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/irqbalance/irqbalance-0.09.ebuild,v 1.2 2004/10/17 09:48:12 dholm Exp $

DESCRIPTION="Distribute hardware interrupts across processors on a multiprocessor system"
HOMEPAGE="http://people.redhat.com/arjanv/irqbalance/"
SRC_URI="http://people.redhat.com/arjanv/irqbalance/${P}.tar.gz"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}/${PN}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	into /
	dosbin irqbalance || die "dosbin failed"
	doman irqbalance.1
	dodoc Changelog TODO
}
