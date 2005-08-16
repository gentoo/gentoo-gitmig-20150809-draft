# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/websvn/websvn-1.61-r1.ebuild,v 1.1 2005/08/16 10:12:19 uberlord Exp $

inherit eutils webapp

MY_PV="161"
DESCRIPTION="Web-based browsing tool for Subversion (SVN) repositories in PHP"
HOMEPAGE="http://websvn.tigris.org/"
SRC_URI="http://websvn.tigris.org/files/documents/1380/14334/WebSVN_${MY_PV}.tar.gz"
LICENSE="GPL-2"
IUSE="enscript"
KEYWORDS="~x86 ~amd64"

RDEPEND=">=dev-php/mod_php-4.1.0
	sys-apps/sed
	enscript? ( >=app-text/enscript-1.6.0 )"
DEPEND="sys-apps/findutils"

S="${WORKDIR}/WebSVN"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	epatch "${FILESDIR}/websvn-1.61-r1.patch"
}

src_compile() {
	mv "${S}/include/distconfig.inc" "${S}/include/config.inc"
}

src_install() {
	webapp_src_preinst

	local doc docs="changes.txt install.txt templates.txt"

	dodoc ${docs}
	for doc in ${docs}; do
		rm -f "${doc}"
	done

	# Remove .cvs* files and CVS directories
	find -name .cvs\* -or \( -type d -name CVS -prune \) | xargs rm -rf

	insinto "${MY_HTDOCSDIR}"
	doins -r *
	webapp_configfile "${MY_HTDOCSDIR}/include/config.inc"

	# This is the multiview config file
	webapp_configfile "${MY_HTDOCSDIR}/wsvn.php"

	# The cache directory needs to be writeable
	webapp_serverowned "${MY_HTDOCSDIR}/cache"

	webapp_src_install
}
