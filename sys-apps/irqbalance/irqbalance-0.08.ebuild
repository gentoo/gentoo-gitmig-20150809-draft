# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/irqbalance/irqbalance-0.08.ebuild,v 1.1 2004/01/11 13:37:17 azarah Exp $

IUSE=

S="${WORKDIR}/irqbalance"
DESCRIPTION="This is a sample skeleton ebuild file"
SRC_URI="http://people.redhat.com/arjanv/irqbalance/${P}.tar.gz"
HOMEPAGE="http://people.redhat.com/arjanv/irqbalance/"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install() {
	into /
	dosbin irqbalance

	doman irqbalance.1

	dodoc COPYING Changelog TODO
}

