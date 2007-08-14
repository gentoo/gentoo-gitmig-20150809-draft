# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/websvn/websvn-2.0.ebuild,v 1.1 2007/08/14 06:33:11 wrobel Exp $

inherit depend.php eutils webapp

MY_PV="${PV//_/}"
DESCRIPTION="Web-based browsing tool for Subversion (SVN) repositories in PHP"
HOMEPAGE="http://websvn.tigris.org/"
SRC_URI="http://websvn.tigris.org/files/documents/1380/39378/websvn-${MY_PV}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
IUSE="enscript"
KEYWORDS="~amd64 ~sparc ~x86"

RDEPEND="virtual/php
	dev-util/subversion
	sys-apps/sed
	enscript? ( app-text/enscript )"

S="${WORKDIR}/websvn-${MY_PV}"

pkg_setup() {
	webapp_pkg_setup

	if ! has_version "=dev-lang/php-5*" ; then
		require_php_with_use expat
	else
		require_php_with_use xml
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	mv "${S}"/include/distconfig.php "${S}"/include/config.php
}

src_install() {
	webapp_src_preinst

	local doc docs="licence.txt changes.txt doc/*"

	dodoc ${docs}
	for doc in ${docs}; do
		rm -f "${doc}"
	done

	insinto "${MY_HTDOCSDIR}"
	doins -r *
	webapp_configfile "${MY_HTDOCSDIR}"/include/config.php

	# This is the multiview config file
	webapp_configfile "${MY_HTDOCSDIR}"/wsvn.php

	# The cache directory needs to be writeable
	webapp_serverowned "${MY_HTDOCSDIR}"/cache

	webapp_src_install
}
