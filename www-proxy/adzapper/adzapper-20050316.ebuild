# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/adzapper/adzapper-20050316.ebuild,v 1.1 2005/03/20 22:34:20 mrness Exp $

MY_P=${P/zapper/zap}

DESCRIPTION="Redirector for squid that intercepts advertising, page counters and some web bugs"
HOMEPAGE="http://adzapper.sourceforge.net/"
SRC_URI="http://adzapper.sourceforge.net/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
IUSE=""

DEPEND=""
RDEPEND="www-proxy/squid"

S="${WORKDIR}/adzap"

src_unpack() {
	unpack ${A}

	SCRPATH="/etc/adzapper/squid_redirect"

	cd ${S}/scripts || die "Error no scripts dir."

	# update the zapper path in various scripts
	for src in wrapzap update-zapper*; do
		mv $src $src.orig || die
		sed -e "s|^zapper=.*|zapper=${SCRPATH}|" \
			-e "s|^ZAPPER=.*|ZAPPER=\"${SCRPATH}\"|" \
			-e "s|^pidfile=.*|pidfile=/var/run/squid.pid|" \
			-e "s|^PIDFILE=.*|PIDFILE=\"/var/run/squid.pid\"|" \
			-e "s|^RESTARTCMD=.*|RESTARTCMD=\"/etc/init.d/squid restart\"|" \
			$src.orig > $src || die "sed updating failed."
			rm $src.orig
	done
}

src_install() {
	cd ${S}/scripts
	exeinto /etc/adzapper
	doexe wrapzap zapchain squid_redirect

	insinto /etc/adzapper
	doins update-zapper*

	cd ${S}/zaps
	insinto /var/www/localhost/htdocs/zap
	doins *
}

pkg_postinst() {
	einfo "To enable adzapper add the following lines to squid.conf:"
	einfo "redirect_program /etc/adzapper/wrapzap"
	einfo "redirect_children 10"
}
