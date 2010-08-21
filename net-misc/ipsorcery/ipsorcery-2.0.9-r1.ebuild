# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipsorcery/ipsorcery-2.0.9-r1.ebuild,v 1.1 2010/08/21 19:13:59 hwoarang Exp $

inherit toolchain-funcs
DESCRIPTION="Ipsorcery allows you to generate IP, TCP, UDP, ICMP, and IGMP packets."
SRC_URI="http://www.legions.org/~phric/ipsorc-${PV}.tar.gz"
HOMEPAGE="http://www.legions.org/~phric/ipsorcery.html"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="gtk"

DEPEND="gtk?	( =x11-libs/gtk+-1.2* )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/ipsorc-${PV}

src_unpack() {
	unpack ${A}
	sed -i -e "s:-g -O2:${CFLAGS} ${LDFLAGS}:g" \
		-e "/^CC/s:=.*$:="$(tc-getCC)":" ${S}/Makefile \
			|| die "sed failed"
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
