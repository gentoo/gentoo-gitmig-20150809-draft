# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/dragonflycms/dragonflycms-9.1.2.1.ebuild,v 1.1 2007/08/15 06:45:13 wrobel Exp $

inherit webapp depend.php

MY_P=Dragonfly${PV}
DESCRIPTION="CPG Dragonfly CMS is a feature-rich open source content management
system based off of PHP-Nuke 6.5"
HOMEPAGE="http://dragonflycms.org"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2
http://dev.gentoo.org/~sejo/files/${MY_P}.tar.bz2"

RESTRICT="fetch"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~x86"
IUSE=""

need_php

pkg_nofetch() {
	einfo "Please download ${MY_P}.tar.bz2 from:"
	einfo "http://dragonflycms.org/Downloads/get=28.html"
	einfo "and move it to ${DISTDIR}"
}

src_install() {

	webapp_src_preinst

	#Do the documentation
	insinto /usr/share/doc/${PF}
	doins -r ${WORKDIR}/documentation/*

	#installing files where they need to be.
	einfo "installing php main files"
	cp -r ${WORKDIR}/public_html/* ${D}${MY_HTDOCSDIR}
	einfo "Done"

	#identiy the configuration file the app uses

	webapp_configfile ${MY_HTDOCSDIR}/install/config.php

	# add the postinstall instructions

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	# manually changing the permissions on the directories
	# if no-suexec then perms should be 777 else 755

	for WS in cpg_error.log includes cache modules/coppermine/albums \
	          modules/coppermine/albums/userpics uploads/avatars     \
	          uploads/forums
	do
	  webapp_serverowned ${MY_HTDOCSDIR}/${WS}
	done

	webapp_src_install

}
