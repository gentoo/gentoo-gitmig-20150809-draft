# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ngircd/ngircd-0.8.3.ebuild,v 1.1 2005/02/03 17:44:49 swegener Exp $

DESCRIPTION="A IRC server written from scratch."
HOMEPAGE="http://arthur.ath.cx/~alex/ngircd/"
SRC_URI="ftp://download.berlios.de/pub/${PN}/${P}.tar.gz
	ftp://ftp.berlios.de/pub/${PN}/${P}.tar.gz
	ftp://arthur.ath.cx/pub/Users/alex/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

IUSE="zlib tcpd debug"

RDEPEND="virtual/libc
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	econf \
		--sysconfdir=/etc/ngircd \
		$(use_with zlib) \
		$(use_with tcpd tcp-wrappers) \
		$(use_enable debug) \
		$(use_enable debug sniffer) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	sed -i \
		-e "s:/usr/local/etc/ngircd.motd:/etc/ngircd/ngircd.motd:" \
		-e "s:;ServerUID = 65534:ServerUID = ngircd:" \
		-e "s:;ServerGID = 65534:ServerGID = nogroup:" \
		doc/sample-ngircd.conf

	make \
		DESTDIR="${D}" \
		docdir=/usr/share/doc/${PF} \
		install || die "make install failed"

	newinitd ${FILESDIR}/ngircd.init.d ngircd
}

pkg_postinst() {
	enewuser ngircd
	chown ngircd ${ROOT}/etc/ngircd/ngircd.conf
}
