# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/adzapper/adzapper-20040104.ebuild,v 1.1 2004/01/19 21:17:14 blkdeath Exp $

inherit webapp-apache

DESCRIPTION="redirector for squid that intercepts advertising, page counters and some web bugs"
HOMEPAGE="http://adzapper.sourceforge.net/"

MY_P=${P/zapper/zap}
S="${WORKDIR}/adzap"

SRC_URI="http://adzapper.sourceforge.net/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND=""
RDEPEND="net-www/squid"

webapp-detect || NO_WEBSERVER=1


pkg_setup() {
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_unpack() {
	unpack ${A}

	SCRPATH="/etc/adzapper/squid_redirect"

	cd ${S}/scripts || die

	# update the zapper path in various scripts
	for src in wrapzap update-zapper*; do
		mv $src $src.orig || die
		sed -e "s|^zapper=.*|zapper=${SCRPATH}|" \
			-e "s|^ZAPPER=.*|ZAPPER=\"${SCRPATH}\"|" \
			-e "s|^pidfile=.*|pidfile=/var/run/squid.pid|" \
			-e "s|^PIDFILE=.*|PIDFILE=\"/var/run/squid.pid\"|" \
			-e "s|^RESTARTCMD=.*|RESTARTCMD=\"/etc/init.d/squid restart\"|" \
			$src.orig > $src || die
			rm $src.orig
	done
}

src_install() {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/

	cd ${S}/scripts
	exeinto /etc/adzapper
	doexe wrapzap zapchain squid_redirect

	insinto /etc/adzapper
	doins update-zapper*

	cd ${S}/zaps
	insinto ${destdir}/zap
	doins *
}

pkg_postinst() {
	einfo "To enable adzapper add the following lines to squid.conf:"
	einfo "redirect_program /etc/adzapper/wrapzap"
	einfo "redirect_children 10"
}
