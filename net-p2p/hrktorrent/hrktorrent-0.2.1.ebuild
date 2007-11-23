# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/hrktorrent/hrktorrent-0.2.1.ebuild,v 1.1 2007/11/23 19:35:24 armin76 Exp $

inherit toolchain-funcs

DESCRIPTION="A slim rb_libtorrent based console torrent application supporting DHT"
HOMEPAGE="http://henrik.unit5.ca/hrktorrent/"
SRC_URI="http://henrik.unit5.ca/hrktorrent/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-cpp/asio
	=net-libs/rb_libtorrent-0.12"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Respect CFLAGS, call g++ correctly, and don't strip
	sed -i -e "s/-O2 -pipe/${CFLAGS}/g" -e "s/g++/$(tc-getCXX)/g" \
		 -e "s/-lpthread -s/-lpthread/g" -e "s/\$(C) -c/\$(C) \$(CFLAGS) -c/g" \
		 Makefile || die "sed failed"
}

src_install() {
	dodir /usr/bin
	cp "${WORKDIR}/${P}/hrktorrent" "${D}/usr/bin" || die "install failed"
	dodoc CHANGELOG README hrktorrent.rc.example
}

pkg_postinst() {
	elog "A sample configuration file for ${PN} can be found"
	elog "in /usr/share/doc/${PF}/hrktorrent.rc.example.{gz,bz2}"
	elog "To use a config file, extract it, put it in your home directory"
	elog "and name it \".hrktorrent.rc\""
}
