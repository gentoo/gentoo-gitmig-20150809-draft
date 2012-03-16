# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/phpvirtualbox/phpvirtualbox-4.1.7.ebuild,v 1.1 2012/03/16 22:44:27 hwoarang Exp $

EAPI="2"

inherit versionator eutils webapp depend.php

MY_PV="$(replace_version_separator 2 '-')"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Web-based administration for VirtualBox in PHP"
HOMEPAGE="http://phpvirtualbox.googlecode.com"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.zip"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-lang/php[session,unicode,soap,gd]
"
DEPEND="app-arch/unzip"

need_php_httpd

src_install() {
	webapp_src_preinst

	cd ${MY_P}

	dodoc CHANGELOG.txt LICENSE.txt README.txt || die
	rm -f CHANGELOG.txt LICENSE.txt README.txt

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_configfile "${MY_HTDOCSDIR}"/config.php-example
	webapp_serverowned "${MY_HTDOCSDIR}"/config.php-example

	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
	elog "Local or remote virtualbox hosts must be compiled with"
	elog "'vboxwebsrv' useflag and the respective init script"
	elog "must be running to use this interface"
	elog " /etc/init.d/vboxwebsrv start"
}
