# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ghostwhitecrab/ghostwhitecrab-0.9.6.1.ebuild,v 1.1 2006/04/26 04:10:09 squinky86 Exp $

inherit eutils versionator

IUSE=""

MY_PV=$(replace_version_separator 3 'r' )
MY_P="gwc-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="stand-alone gwebcache daemon"
HOMEPAGE="http://www.ghostwhitecrab.com/crab/"
SRC_URI="http://www.ghostwhitecrab.com/crab/${MY_P}.tar.bz2"
LICENSE="as-is FDL-1.1"
SLOT="0"
KEYWORDS="~x86 ~hppa ~amd64"

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
	einfo "Please set the \"Location\" of your cache in /etc/${PN}/gwc.conf"
	einfo "and submit your cache to:"
	einfo "\thttp://gcachescan.jonatkins.com/"
}
