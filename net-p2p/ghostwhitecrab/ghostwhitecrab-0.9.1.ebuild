# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ghostwhitecrab/ghostwhitecrab-0.9.1.ebuild,v 1.2 2004/11/27 18:47:59 squinky86 Exp $

inherit eutils

IUSE=""

MY_P="gwc-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="stand-alone gwebcache daemon"
HOMEPAGE="http://www.ghostwhitecrab.com/crab/"
SRC_URI="http://www.ghostwhitecrab.com/crab/${MY_P}.tar.bz2"
LICENSE="as-is FDL-1.1"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4
	sys-libs/zlib
	virtual/libc"
RDEPEND=""

pkg_setup() {
	enewgroup gwc
	enewuser gwc -1 /bin/bash /dev/null gwc
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:#User:User:g' examples/example.conf
	sed -i -e 's:#Group:Group:g' examples/example.conf
	sed -i -e 's:/var/db/gwc:/usr/share/gwc:g' examples/example.conf
	sed -i -e 's:#data_template\t\t/path/to/data_template:data_template\t\t/usr/share/gwc/data_template:g' examples/example.conf
	sed -i -e 's:#base_template\t\t/path/to/base_template:base_template\t\t/usr/share/gwc/base_template:g' examples/example.conf
	sed -i -e 's:sleep 1::g' config.sh
}

src_compile() {
	./config.sh || die
	emake || die
}

src_install() {
	dobin src/gwc
	dodir /etc/${PN}
	insinto /etc/${PN}
	newins examples/example.conf gwc.conf
	dodir /usr/share/gwc
	touch ${D}/usr/share/gwc/peer_cache
	touch ${D}/usr/share/gwc/urls.good
	touch ${D}/usr/share/gwc/urls.bad
	insinto /usr/share/gwc
	newins examples/data_html.template data_template
	newins examples/base_html.template base_template
	chown -R gwc:gwc ${D}/usr/share/gwc
	dodir /var/log/gwc
	touch ${D}/var/log/gwc/main.log
	touch ${D}/var/log/gwc/access.log
	touch ${D}/var/log/gwc/dns.log
	touch ${D}/var/log/gwc/checks.log
	chown -R gwc:gwc ${D}/var/log/gwc
	exeinto /etc/init.d
	newexe ${FILESDIR}/gwc.init gwc
	dohtml doc/*.html doc/*.css doc/specs/*.html
	dodoc doc/specs/*.txt examples/*
}

pkg_postinst() {
	einfo "To have your cache submitted to the gnutella network,"
	einfo "please submit it to:"
	einfo "\thttp://gcachescan.jonatkins.com"
}
