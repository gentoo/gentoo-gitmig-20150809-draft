# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/daapd/daapd-0.2.3b.ebuild,v 1.4 2004/08/28 22:32:18 dholm Exp $

inherit flag-o-matic eutils

DESCRIPTION="daapd scans a directory for mp3 files and makes them available via the Apple proprietary protocol DAAP"
HOMEPAGE="http://www.deleet.de/projekte/daap/daapd/"
SRC_URI="http://www.deleet.de/projekte/daap/daapd/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~x86 ~amd64"
# howl-0.9.6 does not allow this to compile, so amd64 support will still need
# to wait...
KEYWORDS="~x86 ~ppc"
IUSE="mpeg4"
DEPEND="sys-libs/zlib
	=net-misc/howl-0.9.5
	>=media-libs/libid3tag-0.15.0b
	mpeg4? media-libs/faad2
	>=net-libs/libhttpd-persistent-1.3p-r8
	>=media-libs/daaplib-0.1.1a"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch

	if use mpeg4; then
		epatch ${FILESDIR}/${P}-mpeg4.patch
	fi
}

src_compile() {
	emake || die
}

src_install() {

#	emake DESTDIR=${D} DEPLOY=${D}usr install || die "emake install failed"

	dobin daapd
#	dolib daaplib/src/libdaaplib.a
#	dolib libhttpd/src/libhttpd-persistent.a

	dodoc COPYING README* daapd-example.conf
	doman ${PN}.8

#	insinto /usr/include
#	doins libhttpd/src/httpd-persistent.h

	insinto /etc
	newins daapd-example.conf daapd.conf

	insinto /etc/conf.d
	newins ${FILESDIR}/daapd.conf.d daapd || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/daapd.init.d daapd || die
}

