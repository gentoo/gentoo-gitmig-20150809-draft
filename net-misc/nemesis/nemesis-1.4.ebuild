# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nemesis/nemesis-1.4.ebuild,v 1.3 2010/10/28 10:38:19 ssuominen Exp $

inherit eutils

DESCRIPTION="A commandline-based, portable human IP stack for UNIX/Linux"
HOMEPAGE="http://nemesis.sourceforge.net/"
SRC_URI="mirror://sourceforge/nemesis/${P/_}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha ~amd64 sparc x86"
IUSE=""

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}
	=net-libs/libnet-1.0*"

S=${WORKDIR}/${P/_}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-libnet-1.0.patch
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc CREDITS ChangeLog INSTALL README
}
