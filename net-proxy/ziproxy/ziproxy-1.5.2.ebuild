# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/ziproxy/ziproxy-1.5.2.ebuild,v 1.1 2006/01/09 23:21:24 sbriesen Exp $

inherit eutils

DESCRIPTION="A forwarding, non-caching, compressing web proxy server"
HOMEPAGE="http://ziproxy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="jpeg2k"
DEPEND="dev-libs/confuse
	media-libs/giflib
	media-libs/libpng
	media-libs/jpeg
	sys-libs/zlib
	jpeg2k? ( media-libs/jasper )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix sample xinetd config filee
	sed -i -e "s:/home/juro/bin/:/usr/bin/:g" \
		-e "s:/home/juro/ziproxy/:/etc/:g" \
		-e "s:\(disable.*=\).*:\1 yes:g" etc/xinetd.d/ziproxy

	# fix sample config file
	sed -i -e "s:/usr/local/bin/:/usr/bin/:g" \
		-e "s:/var/ziproxy/:/var/lib/ziproxy/:g" \
		-e "s:\(LogFile.*=.*\"\)\(.*\"\):\1/var/log/ziproxy_\2:g" etc/ziproxy.conf
}

src_compile() {
	local myconf="--enable-shared-confuse --with-cfgfile=/etc/ziproxy.conf" # --enable-testprogs
	use jpeg2k && myconf="${myconf} --with-jasper"  # use_with doesn't work
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog CREDITS README
	use jpeg2k && dodoc JPEG2000.txt
	insinto /etc
	doins etc/ziproxy.conf
	insinto /etc/xinetd.d
	doins etc/xinetd.d/ziproxy
	insinto /var/lib/ziproxy/error
	doins var/ziproxy/error/*.html
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
}
