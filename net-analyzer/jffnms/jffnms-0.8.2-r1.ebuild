# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/jffnms/jffnms-0.8.2-r1.ebuild,v 1.1 2007/02/01 16:37:54 jokey Exp $

inherit eutils

DESCRIPTION="Network Management and Monitoring System."
HOMEPAGE="http://www.jffnms.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql postgres snmp"

DEPEND="net-www/apache
	net-analyzer/rrdtool
	media-libs/gd
	=dev-lang/php-4*
	dev-php/PEAR-PEAR
	snmp? ( net-analyzer/net-snmp )
	sys-apps/diffutils
	media-gfx/graphviz
	net-analyzer/nmap
	net-analyzer/fping
	app-mobilephone/smsclient"
RDEPEND=${DEPEND}

pkg_setup() {
	local flags="gd wddx sockets session spl cli"

	if use mysql ; then
		flags="$flags mysql"
	fi

	if use postgres ; then
		flags="$flags postgres"
	fi

	for flagname in $flags ; do
		if ! built_with_use "=dev-lang/php-4*" $flagname; then
			eerror "You need to build php with $flagname USE flag"
			die "Jffnms requires php with $flagname USE flag"
		fi
	done

	enewgroup jffnms
	enewuser jffnms -1 /bin/bash /dev/null jffnms,apache
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

	einfo "JFFNMS has been partialy installed on your system. However you"
	einfo "still need proceed with final installation and configuration."
	einfo "You can visit http://www.gentoo.org/doc/en/jffnms.xml in order"
	einfo "to get detailed information on how to get jffnms up and running."
}
