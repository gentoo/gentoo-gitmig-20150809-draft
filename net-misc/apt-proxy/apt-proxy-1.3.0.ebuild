# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/apt-proxy/apt-proxy-1.3.0.ebuild,v 1.7 2010/10/28 10:41:42 ssuominen Exp $

inherit eutils

DESCRIPTION="Caching proxy for the Debian package system"
HOMEPAGE="http://sourceforge.net/projects/apt-proxy/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=""
RDEPEND="sys-apps/xinetd
	net-misc/rsync
	net-misc/wget"

pkg_setup () {
	enewgroup apt-proxy
	enewuser apt-proxy -1 -1 /dev/null apt-proxy
}

src_compile() {
	#patch -u apt-proxy < ${FILESDIR}/${P}-sh.patch
	epatch "${FILESDIR}"/${P}-sh.patch
}

src_install() {
	dosbin apt-proxy

	insinto /etc/apt-proxy ; doins apt-proxy.conf
	insinto /etc/xinetd.d ; doins "${FILESDIR}"/apt-proxy

	dodoc README INSTALL HISTORY
	doman apt-proxy.{8,conf.5}

	# Create the log file with the proper permissions
	dodir /var/log
	touch "${D}"/var/log/apt-proxy.log
	fowners apt-proxy:apt-proxy /var/log/apt-proxy.log

	# Create the cache directories and set the proper permissions
	dodir /var/cache/apt-proxy
	keepdir /var/cache/apt-proxy
	fowners apt-proxy:apt-proxy /var/cache/apt-proxy
}

pkg_postinst() {
	einfo ""
	einfo "Don't forget to modify the /etc/apt-proxy/apt-proxy.conf"
	einfo "file to fit your needs..."
	einfo ""
	einfo "Also note that apt-proxy is called from running xinetd"
	einfo "and you have to enable it first (/etc/xinetd.d/apt-proxy)..."
	einfo ""
}

pkg_postrm() {
	einfo ""
	einfo "You have to remove the apt-proxy cache by hand. It's located"
	einfo "in the \"/var/cache/apt-proxy\" dir..."
	einfo ""
	einfo "You can also remove the apt-proxy user and group..."
	einfo ""
}
