# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/portfwd/portfwd-0.26_rc6-r1.ebuild,v 1.5 2005/04/01 16:24:01 agriffis Exp $

DESCRIPTION="Port Forwarding Daemon"
SRC_URI="mirror://sourceforge/${PN}/${P/_/}.tar.gz"
HOMEPAGE="http://portfwd.sourceforge.net"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/${P/_/}

	cd src
	sed -iorig \
		-e "s:^CFLAGS   =.*:CFLAGS   = @CFLAGS@ -Wall -DPORTFWD_CONF=\\\\\"\$(sysconfdir)/portfwd.cfg\\\\\":" \
		-e "s:^CXXFLAGS =.*:CPPFLAGS = @CXXFLAGS@ -Wall -DPORTFWD_CONF=\\\\\"\$(sysconfdir)/portfwd.cfg\\\\\":" \
		Makefile.am
	cd ../tools
	sed -iorig \
		-e "s:^CXXFLAGS =.*:CPPFLAGS = @CXXFLAGS@ -Wall -DPORTFWD_CONF=\\\\\"\$(sysconfdir)/portfwd.cfg\\\\\":" \
		Makefile.am
	cd ../getopt
	sed -iorig -e "s:$.CC.:\$(CC) @CFLAGS@:g" Makefile.am
	cd ../doc
	sed -iorig -e "s:/doc/portfwd:/share/doc/$P:" Makefile.am
	cd ..
	sed -iorig -e "s:/doc/portfwd:/share/doc/$P:" Makefile.am
}

src_compile() {
	cd ${WORKDIR}/${P/_/}

	./bootstrap
	econf || die "econf failed"
	emake
}

src_install() {
	cd ${WORKDIR}/${P/_/}

	einstall
	prepalldocs

	dodoc cfg/*

	insinto /etc/init.d
	insopts -m0755
	newins ${FILESDIR}/${PN}.init ${PN}

	insinto /etc/conf.d
	insopts -m0644
	newins ${FILESDIR}/${PN}.confd ${PN}
}

pkg_postinst() {
	einfo "Many configuration file (/etc/portfwd.cfg) samples are available in /usr/share/doc/${P}"
}
