# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/adzapper/adzapper-20031105.ebuild,v 1.3 2004/01/19 21:33:07 blkdeath Exp $

DESCRIPTION="redirector for squid that intercepts advertising, page counters and some web bugs"
HOMEPAGE="http://adzapper.sourceforge.net/"

MY_P=${P/zapper/zap}
S="${WORKDIR}/adzap"

SRC_URI="http://adzapper.sourceforge.net/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

DEPEND=""
RDEPEND="net-www/squid"

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
