# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kismet/kismet-2004.10.1.ebuild,v 1.4 2004/10/27 18:13:34 brix Exp $

inherit gnuconfig

MY_P=${P/\./-}
MY_P=${MY_P/./-R}
S=${WORKDIR}/${MY_P}

ETHEREAL_VERSION="0.10.6"

DESCRIPTION="Kismet is a 802.11b wireless network sniffer."
HOMEPAGE="http://www.kismetwireless.net"
SRC_URI="http://www.kismetwireless.net/code/${MY_P}.tar.gz
		ethereal? http://www.ethereal.com/distribution/ethereal-${ETHEREAL_VERSION}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="ethereal gps"

DEPEND=">=sys-devel/autoconf-2.58
		sys-apps/sed"
RDEPEND="virtual/libc
		net-wireless/wireless-tools
		sys-libs/ncurses
		ethereal? ( =dev-libs/glib-1.2*
				=net-analyzer/ethereal-${ETHEREAL_VERSION}
				sys-libs/zlib )
		gps? ( app-misc/gpsdrive
				>=dev-libs/expat-1.95.4
				dev-libs/gmp
				>=media-gfx/imagemagick-6.0
				dev-perl/libwww-perl )"
		# Note: gps support is automatically enabled based on the
		# above libs - 2004-10-R1 doesn't honor the --disable-gps flag
		# brix@gentoo.org

src_unpack() {
	unpack ${A}

	# make sure we compile against installed linux-sources if available
	sed -i "s:-I/lib/modules/.*/build/include/:-I/usr/src/linux/include/:g" \
		${S}/configure

	gnuconfig_update ${S}
}

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
		|| die "econf failed"

	emake dep || die "emake dep failed"
	emake || die "make failed"
}

src_install () {
	emake DESTDIR=${D} install || die "emake install failed"

	dodoc CHANGELOG README TODO docs/*

	exeinto /etc/init.d
	newexe ${FILESDIR}/${P}-init.d kismet

	insinto /etc/conf.d
	newins ${FILESDIR}/${P}-conf.d kismet
}

pkg_postinst() {
	einfo ""
	einfo "Please notice that the config file location has changed from"
	einfo "/etc/kismet to /etc/"
	einfo ""
	einfo "For usage instructions please see"
	einfo "/usr/share/doc/${PF}/README.gz"
	einfo ""
}
