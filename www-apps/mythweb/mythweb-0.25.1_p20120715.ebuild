# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mythweb/mythweb-0.25.1_p20120715.ebuild,v 1.1 2012/07/15 23:37:01 cardoe Exp $

EAPI=4

inherit webapp depend.php

BACKPORTS="4f6ac2a60b"
# Release version
MY_PV="${PV%_p*}"
MY_P="mythplugins-${MY_PV}"

DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
HOMEPAGE="http://www.mythtv.org"
LICENSE="GPL-2"
SRC_URI="ftp://ftp.osuosl.org/pub/mythtv/${MY_P}.tar.bz2
	${BACKPORTS:+http://dev.gentoo.org/~cardoe/distfiles/${MY_P}-${BACKPORTS}.tar.xz}"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="dev-lang/php:5.3[json,mysql,session,posix]
	dev-perl/DBI
	dev-perl/DBD-mysql
	dev-perl/HTTP-Date
	dev-perl/Net-UPnP"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}/${PN}"

need_httpd_cgi
need_php5_httpd

src_prepare() {
	cd "${S}"/../

	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/../patches" \
			epatch

	epatch_user
}

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	webapp_src_preinst

	# Install docs
	cd "${S}"
	dodoc README INSTALL

	# Install htdocs files
	insinto "${MY_HTDOCSDIR}"
	doins mythweb.php
	doins -r classes
	doins -r configuration
	doins -r data
	doins -r includes
	doins -r js
	doins -r modules
	doins -r skins
	doins -r tests
	exeinto "${MY_HTDOCSDIR}"
	doexe mythweb.pl

	# Install our server config files
	webapp_server_configfile apache mythweb.conf.apache mythweb.conf
	webapp_server_configfile lighttpd mythweb.conf.lighttpd mythweb.conf
	webapp_server_configfile nginx "${FILESDIR}"/mythweb.conf.nginx \
		mythweb.include

	# Data needs to be writable and modifiable by the web server
	webapp_serverowned -R "${MY_HTDOCSDIR}"/data

	# Message to display after install
	#webapp_postinst_txt en "${FILESDIR}"/0.24-postinstall-en.txt

	# Script to set the correct defaults on install
	webapp_hook_script "${FILESDIR}"/reconfig

	webapp_src_install
}
