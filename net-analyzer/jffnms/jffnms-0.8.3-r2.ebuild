# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/jffnms/jffnms-0.8.3-r2.ebuild,v 1.3 2012/06/12 02:27:51 zmedico Exp $

inherit depend.apache eutils depend.php user

DESCRIPTION="Network Management and Monitoring System."
HOMEPAGE="http://www.jffnms.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql postgres snmp"

DEPEND="net-analyzer/rrdtool
	media-libs/gd
	dev-php/PEAR-PEAR
	net-analyzer/net-snmp
	sys-apps/diffutils
	app-mobilephone/smsclient"

RDEPEND="${DEPEND}
	media-gfx/graphviz
	net-analyzer/nmap
	net-analyzer/fping"

need_apache
need_php_cli

pkg_setup() {
	local flags="pcre session snmp sockets wddx"
	use mysql && flags="${flags} mysql"
	use postgres &&	flags="${flags} postgres"

	if ! PHPCHECKNODIE="yes" require_php_with_use ${flags} \
		|| ! PHPCHECKNODIE="yes" require_php_with_any_use gd gd-external ; then
		eerror
		eerror "${PHP_PKG} needs to be re-installed with all of the following"
		eerror "USE flags enabled:"
		eerror
		eerror "${flags}"
		eerror
		eerror "as well as any of the following USE flags enabled:"
		eerror
		eerror "gd or gd-external"
		eerror
		die "Re-install ${PHP_PKG} with ${flags} and either gd or gd-external"
	fi

	enewgroup jffnms
	enewuser jffnms -1 /bin/bash -1 jffnms,apache
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fixes Multiple vulnerabilities bug #192240
	epatch "${FILESDIR}"/${P}-misc-security-fixes.patch
}

src_install(){
	INSTALL_DIR="/opt/${PN}"
	IMAGE_DIR="${D}${INSTALL_DIR}"

	dodir "${INSTALL_DIR}"
	cp -r * "${IMAGE_DIR}" || die
	rm -f "${IMAGE_DIR}/LICENSE"

	# Clean up windows related stuff
	rm -f "${IMAGE_DIR}/*.win32.txt"
	rm -rf "${IMAGE_DIR}/docs/windows"
	rm -rf "${IMAGE_DIR}/engine/windows"

	chown -R jffnms:apache "${IMAGE_DIR}" || die
	chmod -R ug+rw "${IMAGE_DIR}" || die

	elog "${PN} has been partialy installed on your system. However you"
	elog "still need proceed with final installation and configuration."
	elog "You can visit http://www.gentoo.org/doc/en/jffnms.xml in order"
	elog "to get detailed information on how to get jffnms up and running."
}
