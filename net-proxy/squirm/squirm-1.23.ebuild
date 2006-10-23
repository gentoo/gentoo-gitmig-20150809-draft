# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/squirm/squirm-1.23.ebuild,v 1.5 2006/10/23 18:18:07 mrness Exp $

DESCRIPTION="A redirector for Squid"
HOMEPAGE="http://squirm.foote.com.au"
SRC_URI="http://squirm.foote.com.au/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="net-proxy/squid"

src_unpack() {
	unpack ${A}

	sed -i \
		-e 's|^EXTRALIBS=.*|EXTRALIBS=|' \
		-e 's|^PREFIX=.*|PREFIX=/usr/squirm|' \
		-e "s|^OPTIMISATION=.*|OPTIMISATION=${CFLAGS}|" \
		-e "s|^CFLAGS =.*|CFLAGS=${CFLAGS} -DPREFIX=\\\\\"\$(PREFIX)\\\\\"|" \
		"${S}/Makefile"
}

src_install() {
	make PREFIX="${D}/usr/squirm" install || die "make install failed"
}

pkg_postinst() {
	einfo "To enable squirm, add the following lines to /etc/squid/squid.conf:"
	einfo " - for squid ver 2.5"
	einfo "    ${HILITE}redirect_program /usr/squirm/bin/squirm${NORMAL}"
	einfo "    ${HILITE}redirect_children 10${NORMAL}"
	einfo " - for squid ver 2.6"
	einfo "    ${HILITE}url_rewrite_program /usr/squirm/bin/squirm${NORMAL}"
	einfo "    ${HILITE}url_rewrite_children 10${NORMAL}"
}
