# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/daapd/daapd-0.2.3d-r1.ebuild,v 1.1 2005/01/30 01:23:48 luckyduck Exp $

IUSE="aac howl mpeg4"

inherit flag-o-matic eutils

DESCRIPTION="daapd scans a directory for mp3 files and makes them available via the Apple proprietary protocol DAAP"
HOMEPAGE="http://www.deleet.de/projekte/daap/daapd/"
SRC_URI="http://www.deleet.de/projekte/daap/daapd/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc"

DEPEND="sys-libs/zlib
	howl? ( >=net-misc/howl-0.9.6-r1 )
	aac? ( media-libs/faad2 )
	>=media-libs/libid3tag-0.15.0b
	>=net-libs/libhttpd-persistent-1.3p-r8
	>=media-libs/daaplib-0.1.1a"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch

	cd ${S}
	if ! use howl; then
		sed -ie 's/HOWL_ENABLE = 1/HOWL_ENABLE = 0/g' makefile
	fi

	if ! use mpeg4; then
		sed -ie 's/MPEG4_ENABLE = 1/MPEG4_ENABLE = 0/g' makefile
	fi
}

src_compile() {
	emake || die
}

src_install() {
	dobin daapd

	dodoc COPYING README* daapd-example.conf
	doman ${PN}.8

	insinto /etc
	newins daapd-example.conf daapd.conf

	insinto /etc/conf.d
	newins ${FILESDIR}/daapd.conf.d daapd || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/daapd.init.d daapd || die
}

