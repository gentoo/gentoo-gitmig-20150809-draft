# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/squirrelmail/squirrelmail-1.4.2-r1.ebuild,v 1.5 2003/12/15 20:23:58 stuart Exp $

inherit webapp-apache

DESCRIPTION="Webmail for nuts!"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://www.squirrelmail.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ppc sparc alpha ~amd64"

RDEPEND=">=mod_php-4.1
	dev-perl/DB_File"
DEPEND="${RDEPEND}"

webapp-detect || NO_WEBSERVER=1

pkg_setup() {
	webapp-pkg_setup "${NO_WEBSERVER}"
	if [ -L ${HTTPD_ROOT}/${PN} ] ; then
		ewarn "You need to unmerge your old SquirrelMail version first."
		ewarn "SquirrelMail will be installed into ${HTTPD_ROOT}/${PN}"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_compile() {
	#we need to have this empty function ... default compile hangs
	echo "Nothing to compile"
}

src_install() {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}
	dodir ${destdir}
	cp -r . ${D}/${HTTPD_ROOT}/${PN}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${PN}/data
	# Fix permissions
	find ${D}${destdir} -type d | xargs chmod 755
	find ${D}${destdir} -type f | xargs chmod 644
}

pkg_postinst() {
	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}

	einfo "now copy ${destdir}/config/config_default.php to"
	einfo "${destdir}/config/config.php"
	einfo "and edit your settings"
	einfo
	old_ver=`ls ${HTTPD_ROOT}/${PN}-[0-9]* 2>/dev/null`
	if [ ! -z "${old_ver}" ]; then
		einfo ""
		einfo "You will also want to move old SquirrelMail data to"
		einfo "the new location:"
		einfo ""
		einfo "\tmv ${HTTPD_ROOT}/${PN}-OLDVERSION/data/* \\"
		einfo "\t\t${HTTPD_ROOT}/${PN}/data"
		einfo "\tmv ${HTTPD_ROOT}/${PN}-OLDVERSION/config/config.php \\"
		einfo "\t\t${HTTPD_ROOT}/${PN}/config"
	fi
}
