# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wepdecrypt/wepdecrypt-0.8.ebuild,v 1.9 2011/03/20 20:02:37 jlec Exp $

EAPI="1"

inherit eutils

MY_P="${P}"
DESCRIPTION="Enhanced version of WepAttack a tool for breaking 802.11 WEP keys"
HOMEPAGE="http://wepdecrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/wepdecrypt/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X"
RDEPEND="X? ( x11-libs/fltk:1 )
	sys-libs/zlib
	net-libs/libpcap
	dev-libs/openssl"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-build.patch"
}

src_compile() {
	# build system is broken and --enabled-gui doesn't work
	if use X; then
		econf  || die "econf failed"
	else
		econf --disable-gui || die "econf failed"
	fi

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}"
}
