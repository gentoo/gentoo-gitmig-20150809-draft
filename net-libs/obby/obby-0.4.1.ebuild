# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/obby/obby-0.4.1.ebuild,v 1.1 2006/08/29 23:02:28 humpback Exp $

#MY_P=${P/_rc/rc}
#S=${WORKDIR}/${MY_P}
inherit eutils

DESCRIPTION="Library for collaborative text editing"
HOMEPAGE="http://darcs.0x539.de/libobby"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="howl"
SRC_URI="http://releases.0x539.de/${PN}/${P/_/}.tar.gz"

DEPEND=">=net-libs/net6-1.3.1
		>=dev-libs/libsigc++-2.0
		>=dev-libs/gmp-4.1.4
		howl? ( >=net-misc/howl-0.9.8 )"

RDEPEND=""

S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${A}
#	cd ${S}
#	epatch ${FILESDIR}/dual_subscribe.patch
}

src_compile() {

	local myconf
	myconf="${myconf} --disable-tests"
	use howl && myconf="${myconf} --with-howl"
	econf ${myconf} || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
