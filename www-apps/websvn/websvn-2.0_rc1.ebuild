# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/websvn/websvn-2.0_rc1.ebuild,v 1.1 2006/05/08 11:24:31 uberlord Exp $

inherit eutils webapp

MY_PV="${PV//_/}"
DESCRIPTION="Web-based browsing tool for Subversion (SVN) repositories in PHP"
HOMEPAGE="http://websvn.tigris.org/"
SRC_URI="http://websvn.tigris.org/files/documents/1380/31740/WebSVN_${MY_PV}.tar.gz"
LICENSE="GPL-2"
IUSE="enscript"
KEYWORDS="~amd64 ~sparc ~x86"

RDEPEND="virtual/php
	dev-util/subversion
	sys-apps/sed
	enscript? ( app-text/enscript )"

S="${WORKDIR}/WebSVN-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}"-pathinfo.patch
}

src_compile() {
	mv "${S}"/include/distconfig.inc "${S}"/include/config.inc
}

src_install() {
	webapp_src_preinst

	local doc docs="changes.txt templates.txt"

	dodoc ${docs}
	for doc in ${docs} install.txt ; do
		rm -f "${doc}"
	done

	insinto "${MY_HTDOCSDIR}"
	doins -r *
	webapp_configfile "${MY_HTDOCSDIR}"/include/config.inc

	# This is the multiview config file
	webapp_configfile "${MY_HTDOCSDIR}"/wsvn.php

	# The cache directory needs to be writeable
	webapp_serverowned "${MY_HTDOCSDIR}"/cache

	webapp_src_install
}
