# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-vcalendar/sylpheed-claws-vcalendar-0.4.ebuild,v 1.3 2004/10/19 10:19:31 absinthe Exp $

inherit eutils

MY_P="${P##sylpheed-claws-}"

DESCRIPTION="Plugin for sylpheed-claws to send and receive vcal messages"
HOMEPAGE="http://sylpheed-claws.sourceforge.net"
SRC_URI="http://sylpheed-claws.sourceforge.net/downloads/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-0.9.12b-r1
		>=dev-libs/libical-0.24_rc4-r1"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${MY_P}-ical.patch"
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
}
