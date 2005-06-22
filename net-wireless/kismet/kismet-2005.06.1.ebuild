# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kismet/kismet-2005.06.1.ebuild,v 1.1 2005/06/22 21:36:34 brix Exp $

inherit linux-info

MY_P=${P/\./-}
MY_P=${MY_P/./-R}
S=${WORKDIR}/${MY_P}

ETHEREAL_VERSION="0.10.11"

DESCRIPTION="IEEE 802.11 wireless LAN sniffer"
HOMEPAGE="http://www.kismetwireless.net"
SRC_URI="http://www.kismetwireless.net/code/${MY_P}.tar.gz
		ethereal? ( http://www.ethereal.com/distribution/ethereal-${ETHEREAL_VERSION}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="ethereal gps gtk2 ncurses"

DEPEND=">=sys-devel/autoconf-2.58
		sys-apps/sed"
RDEPEND="net-wireless/wireless-tools
		ncurses? ( sys-libs/ncurses )
		ethereal? ( >=net-analyzer/ethereal-${ETHEREAL_VERSION}
				sys-libs/zlib
				gtk2? ( =dev-libs/glib-1.2* )
				!gtk2? ( >=dev-libs/glib-2.0.4 ) )
		gps? ( app-misc/gpsdrive
				>=dev-libs/expat-1.95.4
				dev-libs/gmp
				>=media-gfx/imagemagick-6.0
				dev-perl/libwww-perl )"

src_unpack() {
	unpack ${A}

	sed -i -e "s:^\(logtemplate\)=\(.*\):\1=/tmp/\2:" \
		${S}/conf/kismet.conf.in
}

src_compile() {
	# the configure script only honors '--disable-foo'
	local config=""

	if ! use ncurses; then
		config="${config} --disable-curses --disable-panel"
	fi

	if ! use gps; then
		# Note: gps support is automatically enabled based on the
		# libs in RDEPEND - 2005-06-R1 doesn't honor the --disable-gps flag
		config="${config} --disable-gps"
	fi

	if use ethereal; then
		cd ${WORKDIR}/ethereal-${ETHEREAL_VERSION}/wiretap

		econf \
			$(use_enable gtk2) \
			--disable-usr-local \
			|| die "wiretap econf failed"
		emake || die "wiretap emake failed"

		config="${config} --with-ethereal=${WORKDIR}/ethereal-${ETHEREAL_VERSION}"
		cd ${S}
	fi

	econf \
		${config} \
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
