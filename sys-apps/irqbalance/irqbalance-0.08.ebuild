# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/irqbalance/irqbalance-0.08.ebuild,v 1.2 2004/05/24 21:37:34 lv Exp $

IUSE=

S="${WORKDIR}/irqbalance"
DESCRIPTION="This is a sample skeleton ebuild file"
SRC_URI="http://people.redhat.com/arjanv/irqbalance/${P}.tar.gz"
HOMEPAGE="http://people.redhat.com/arjanv/irqbalance/"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"

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

