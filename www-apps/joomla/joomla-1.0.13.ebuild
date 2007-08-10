# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/joomla/joomla-1.0.13.ebuild,v 1.2 2007/08/10 01:54:39 mr_bones_ Exp $

inherit webapp depend.php

DESCRIPTION="Joomla is one of the most powerful Open Source Content Management Systems on the planet."
HOMEPAGE="http://www.joomla.org/"
SRC_URI="http://downloads.joomlacode.org/frsrelease/1/3/2/13215/Joomla_${PV}-Stable-Full_Package.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
S="${WORKDIR}"

IUSE=""

need_php

pkg_setup () {
	webapp_pkg_setup
	require_php_with_use mysql zlib
}

src_install () {
	webapp_src_preinst
	local files="administrator/backups administrator/components
	administrator/modules administrator/templates cache components
	images images/banners images/stories language mambots mambots/content
	mambots/editors mambots/editors-xtd mambots/search mambots/system
	media modules templates"

	dodoc CHANGELOG.php INSTALL.php

	cp -R . "${D}/${MY_HTDOCSDIR}"

	for file in ${files}; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	webapp_postinst_txt en "${FILESDIR}/postinstall-en.txt"

	webapp_src_install
}
