# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kismet/kismet-2005.08.1-r1.ebuild,v 1.2 2006/04/26 15:05:32 brix Exp $

inherit eutils linux-info

MY_P=${P/\./-}
MY_P=${MY_P/./-R}
S=${WORKDIR}/${MY_P}

DESCRIPTION="IEEE 802.11 wireless LAN sniffer"
HOMEPAGE="http://www.kismetwireless.net"
SRC_URI="http://www.kismetwireless.net/code/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="gps ncurses"

RDEPEND="net-wireless/wireless-tools
		ncurses? ( sys-libs/ncurses )
		gps? ( app-misc/gpsdrive
				>=dev-libs/expat-1.95.4
				dev-libs/gmp
				>=media-gfx/imagemagick-6.0
				dev-perl/libwww-perl )"
DEPEND="${RDEPEND}
		>=sys-devel/autoconf-2.58
		sys-apps/sed"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-acx100.patch

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
		config="${config} --disable-gpsmap"
	fi

	econf \
		${config} \
		--with-linuxheaders=${KV_DIR}/include \
		|| die "econf failed"

	einfo "You may safely ignore the warning about the missing .depend file"
	emake dep || die "emake dep failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR=${D} install || die "emake install failed"

	dodoc CHANGELOG README TODO docs/*

	newinitd ${FILESDIR}/${P}-init.d kismet
	newconfd ${FILESDIR}/${P}-conf.d kismet
}
