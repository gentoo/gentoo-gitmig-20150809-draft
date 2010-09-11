# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-webmail/horde-webmail-1.2.4.ebuild,v 1.2 2010/09/11 15:14:44 mabi Exp $

HORDE_PN=${PN}

HORDE_APPLICATIONS="dimp imp ingo kronolith mimp mnemo nag turba"

inherit horde

DESCRIPTION="browser based communication suite"
HOMEPAGE="http://www.horde.org/webmail/"

HORDE_PATCHSET_REV=1

SRC_URI="${SRC_URI}
	kolab? ( http://files.pardus.de/horde-webmail-patches-1.2-r${HORDE_PATCHSET_REV}.tar.bz2 )"

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="crypt mysql postgres ldap oracle kolab"

DEPEND=""
RDEPEND="!www-apps/horde
	crypt? ( app-crypt/gnupg )
	dev-lang/php
	>=www-apps/horde-pear-1.3
	dev-php/PEAR-Log
	dev-php/PEAR-Mail_Mime
	dev-php/PEAR-DB"

EHORDE_PATCHES="$(use kolab && echo ${WORKDIR}/horde-webmail-kolab.patch)"
HORDE_RECONFIG="$(use kolab && echo ${FILESDIR}/reconfig.kolab)"
HORDE_POSTINST="$(use kolab && echo ${FILESDIR}/postinstall-en.txt.kolab)"

pkg_setup() {
	HORDE_PHP_FEATURES="
		imap ssl session xml nls iconv gd ftp
		$(use ldap && echo ldap) $(use oracle && echo oci8)
		$(use crypt && echo crypt) $(use mysql && echo mysql mysqli)
		$(use postgres && echo postgres) $(use kolab && echo kolab sqlite)
	"
	horde_pkg_setup
}
