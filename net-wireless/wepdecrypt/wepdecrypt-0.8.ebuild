# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wepdecrypt/wepdecrypt-0.8.ebuild,v 1.2 2006/10/22 15:16:48 peper Exp $

inherit eutils

MY_P="${PN}-${PV}"
DESCRIPTION="Enhanced version of WepAttack a tool for breaking 802.11 WEP keys"
HOMEPAGE="http://wepdecrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/wepdecrypt/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X"

RDEPEND="X? ( >=x11-libs/fltk-1.1.6 )
	sys-libs/zlib
	net-libs/libpcap
	dev-libs/openssl"

DEPEND="${RDEPEND}"

src_compile() {
	local conf
	if ! use X
	then
		conf=--disable-gui
	fi
	econf ${conf} || die "econf failed"
	emake || die "emake failed"
}


src_install() {
	dobin src/wepdecrypt run/wepdecrypt_{inc,word} src/wkeygen || die

	if use X; then
		dobin src/gwepdecrypt || die
	fi

	insinto /etc
	doins conf/wepdecrypt.conf
	doman doc/wepdecrypt.1 doc/wkeygen.1
	dodoc CHANGELOG README TODO doc/manual.html doc/manual.txt doc/Examples.txt
}

