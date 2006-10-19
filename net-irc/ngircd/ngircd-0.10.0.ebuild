# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ngircd/ngircd-0.10.0.ebuild,v 1.1 2006/10/19 22:08:18 jokey Exp $

inherit eutils

DESCRIPTION="A IRC server written from scratch."
HOMEPAGE="http://arthur.ath.cx/~alex/ngircd/"
SRC_URI="ftp://download.berlios.de/pub/${PN}/${P}.tar.gz
	ftp://ftp.berlios.de/pub/${PN}/${P}.tar.gz
	ftp://arthur.ath.cx/pub/Users/alex/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="zlib tcpd debug ident"

DEPEND="virtual/libc
	zlib? ( sys-libs/zlib )
	ident? ( net-libs/libident )
	tcpd? ( sys-apps/tcp-wrappers )
	>=sys-apps/sed-4"

src_compile() {
	econf \
		--sysconfdir=/etc/ngircd \
		$(use_with zlib) \
		$(use_with tcpd tcp-wrappers) \
		$(use_with ident ) \
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

	newinitd "${FILESDIR}"/ngircd.init.d ngircd
}

pkg_postinst() {
	enewuser ngircd
	chown ngircd "${ROOT}"/etc/ngircd/ngircd.conf
}
