# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/ziproxy/ziproxy-2.5.1.ebuild,v 1.1 2008/03/16 23:34:41 sbriesen Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils

DESCRIPTION="A forwarding, non-caching, compressing web proxy server"
HOMEPAGE="http://ziproxy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="jpeg2k xinetd"

DEPEND="media-libs/giflib
	media-libs/libpng
	media-libs/jpeg
	sys-libs/zlib
	jpeg2k? ( media-libs/jasper )"
RDEPEND="${DEPEND}
	xinetd? ( virtual/inetd )"

pkg_setup() {
	enewgroup ziproxy
	enewuser ziproxy -1 -1 -1 ziproxy
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix sample config file
	sed -i -e "s:/var/ziproxy/:/var/lib/ziproxy/:g" \
		etc/ziproxy/ziproxy.conf

	# fix sample xinetd config
	sed -i -e "s:/usr/bin/:/usr/sbin/:g" \
		-e "s:\(.*port.*\):\1\n\ttype\t\t\t= UNLISTED:g" \
		-e "s:root:ziproxy:g" etc/xinetd.d/ziproxy
}

src_compile() {
	local myconf="--with-cfgfile=/etc/ziproxy/ziproxy.conf"  # --enable-testprogs
	use jpeg2k && myconf="${myconf} --with-jasper"  # use_with doesn't work
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodir /usr/sbin
	mv -f "${D}usr/bin/ziproxy" "${D}usr/sbin/ziproxy"

	newbin stats.awk ${PN}_stats.awk
	dobin src/tools/ziproxy_genhtml_stats.sh

	newinitd "${FILESDIR}/${PN}-${PV%.*}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}-${PV%.*}.confd" ${PN}

	dodoc ChangeLog CREDITS README README.tools
	use jpeg2k && dodoc JPEG2000.txt

	insinto /etc
	doins -r etc/ziproxy

	insinto /var/lib/ziproxy/error
	doins var/ziproxy/error/*.html

	if use xinetd; then
		insinto /etc/xinetd.d
		doins etc/xinetd.d/ziproxy
	fi

	diropts -m0750 -o ziproxy -g ziproxy
	keepdir /var/log/ziproxy
}
