# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/aolserver.eclass,v 1.4 2005/02/12 02:50:24 port001 Exp $

# Authors:
#	Ian Leitch <port001@gentoo.org>

ECLASS=aolserver
INHERITED="$INHERITED $ECLASS"

DEPEND="$DEPEND www-servers/aolserver"
RDEPEND="$RDEPEND www-servers/aolserver"

NS_CONF="/usr/share/aolserver" # /include/ is implied by the Makefile
NS_BASE="/usr/lib/aolserver"

SRC_URI="mirror://sourceforge/aolserver/${P}.tar.gz"
HOMEPAGE="http://www.aolserver.com"
LICENSE="MPL-1.1"
SLOT="0"

src_compile() {

	emake NSBUILD=1 INST=${NS_CONF} ${MAKE_FLAGS} || die "emake failed"
}

src_install() {

	find ${S} -type d -name CVS -prune | xargs rm -rf

	into ${NS_BASE}
	dobin ${S}/${PN}.so
}

pkg_postinst() {

	echo
	einfo "To enable the use of ${PN} you must add the module to your AOLServer configuration"
	echo
}
