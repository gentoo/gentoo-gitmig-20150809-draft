# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kismet/kismet-2005.04.1.ebuild,v 1.1 2005/04/03 11:06:39 brix Exp $

inherit linux-info

MY_P=${P/\./-}
MY_P=${MY_P/./-R}
S=${WORKDIR}/${MY_P}

ETHEREAL_VERSION="0.10.10"

DESCRIPTION="Kismet is a 802.11b wireless network sniffer."
HOMEPAGE="http://www.kismetwireless.net"
SRC_URI="http://www.kismetwireless.net/code/${MY_P}.tar.gz
		ethereal? ( http://www.ethereal.com/distribution/ethereal-${ETHEREAL_VERSION}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="ethereal gps"

DEPEND=">=sys-devel/autoconf-2.58"
RDEPEND="virtual/libc
		net-wireless/wireless-tools
		sys-libs/ncurses
		ethereal? ( =dev-libs/glib-1.2*
				>=net-analyzer/ethereal-${ETHEREAL_VERSION}
				sys-libs/zlib )
		gps? ( app-misc/gpsdrive
				>=dev-libs/expat-1.95.4
				dev-libs/gmp
				>=media-gfx/imagemagick-6.0
				dev-perl/libwww-perl )"
		# Note: gps support is automatically enabled based on the
		# above libs - 2005-04-R1 doesn't honor the --disable-gps flag
		# brix@gentoo.org

src_compile() {
	local ETHEREAL_APPEND=""

	if use ethereal
	then
		cd ${WORKDIR}/ethereal-${ETHEREAL_VERSION}/wiretap
		econf || die "wiretap econf failed"
		emake || die "wiretap emake failed"
		cd ${S}

		ETHEREAL_APPEND="=${WORKDIR}/ethereal-${ETHEREAL_VERSION}"
	fi

	econf \
		`use_with ethereal ethereal${ETHEREAL_APPEND}` \
		`use_enable ncurses curses` \
		--with-linuxheaders=${KV_DIR}/include \
		|| die "econf failed"

	emake dep || die "emake dep failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR=${D} install || die "emake install failed"

	dodoc CHANGELOG README TODO docs/*

	newinitd ${FILESDIR}/${P}-init.d kismet
	newconfd ${FILESDIR}/${P}-conf.d kismet
}
