# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/daapd/daapd-0.2.1d.ebuild,v 1.1 2004/03/31 02:20:20 eradicator Exp $

inherit flag-o-matic eutils

DESCRIPTION="daapd scans a directory for mp3 files and makes them available via the Apple proprietary protocol DAAP"
HOMEPAGE="http://www.deleet.de/projekte/daap/daapd/"
SRC_URI="http://www.deleet.de/projekte/daap/daapd/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="sys-libs/zlib
	>=media-libs/libid3tag-0.15.0b
	>=net-libs/libhttpd-persistent-1.3p-r6
	media-libs/daaplib
	>=net-misc/howl-0.9"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-makefile-gentoo.patch
	epatch ${FILESDIR}/${PV}-zeroconf-gentoo.patch
}

src_compile() {
	if eval [ -d "/usr/include/howl-*" ]; then
		INCPATH="-I "`echo /usr/include/howl-*` || die "Can't find howl includes."
	fi

	emake INCPATH="${INCPATH}" || die
}

src_install() {
	# Not an automake build :(
	dobin daapd

	dodoc COPYING INSTALL.irix README daapd-example.conf

	insinto /etc
	newins daapd-example.conf daapd.conf

	insinto /etc/conf.d
	newins ${FILESDIR}/daapd.conf.d daapd || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/daapd.init.d daapd || die
}
