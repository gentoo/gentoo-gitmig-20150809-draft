# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipsorcery/ipsorcery-2.0.9.ebuild,v 1.3 2007/07/12 02:52:16 mr_bones_ Exp $

DESCRIPTION="Ipsorcery allows you to generate IP, TCP, UDP, ICMP, and IGMP packets."
SRC_URI="http://www.legions.org/~phric/ipsorc-${PV}.tar.gz"
HOMEPAGE="http://www.legions.org/~phric/ipsorcery.html"
KEYWORDS="~ppc ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="gtk"
DEPEND="gtk?	( =x11-libs/gtk+-1.2* )"
RDEPEND="${DEPEND}"
S=${WORKDIR}/ipsorc-${PV}

src_unpack() {
	unpack ${A}
	sed -i -e "s:-O2:$CFLAGS:g" ${S}/Makefile
}

src_compile () {
	if use gtk; then
		emake all || die
	else
		make con || die
	fi
}

src_install () {
	if use gtk; then
		dosbin magic
	fi
	dosbin ipmagic
	dodoc README HOWTO
}
