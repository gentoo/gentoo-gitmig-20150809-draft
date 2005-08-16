# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/dragonflycms/dragonflycms-9.0.5.0.ebuild,v 1.4 2005/08/16 05:15:05 vapier Exp $

inherit webapp

MY_P=Dragonfly${PV}
DESCRIPTION="CPG Dragonfly CMS is a feature-rich open source content management
system based off of PHP-Nuke 6.5"
HOMEPAGE="http://dragonflycms.org"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2
http://dev.gentoo.org/~sejo/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~arm ~ppc ~s390 ~x86"
IUSE=""

RDEPEND=">=dev-db/mysql-3.23.32 <dev-db/mysql-5.1
	 virtual/httpd-php"
DEPEND=""

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

	webapp_configfile ${MY_HTDOCSDIR}/config.php

	# add the postinstall instructions

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	# done, now strut the stuff

	webapp_src_install

	# manually changing the permissions on the directories
	# if no-suexec then perms should be 777 else 755

	if useq no-suexec; then
		PERMS=777
	else
		PERMS=755
	fi
	fperms 600 ${D}/cpg_error.log
	fperms ${PERMS} ${D}/cache
	fperms ${PERMS} ${D}/modules/coppermine/albums
	fperms ${PERMS} ${D}/modules/coppermine/albums/userpics
	fperms ${PERMS} ${D}/uploads/{avatars,forums}
}
