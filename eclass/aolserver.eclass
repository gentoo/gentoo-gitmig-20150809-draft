# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/aolserver.eclass,v 1.1 2005/01/05 13:37:56 port001 Exp $

# Authors:
#	Ian Leitch <port001@gentoo.org>

ECLASS=aolserver
INHERITED="$INHERITED $ECLASS"
EXPORT_FUNCTIONS src_compile src_install pkg_postinst

DEPEND="$DEPEND www-servers/aolserver"
RDEPEND="$RDEPEND www-servers/aolserver"

NS_CONF="/usr/share/aolserver" # /include/ is implied by the Makefile
NS_BASE="/usr/lib/aolserver"

# For nsxml
LIBXML2=/usr
LIBXSLT=/usr

IUSE=""
HOMEPAGE="http://www.aolserver.com"
LICENSE="MPL-1.1"
SLOT="0"

aolserver_src_compile() {

	emake NSBUILD=1 INST=${NS_CONF} LIBXML2=${LIBXML2} LIBXSLT=${LIBXSLT} || die "emake failed"
}

aolserver_src_install() {

	find ${S} -type d -name CVS -prune | xargs rm -rf

	into ${NS_BASE}
	dobin ${S}/${PN}.so
}

aolserver_pkg_postinst() {

	echo
	einfo "To enable the use of ${PN} you must add the module to your AOLServer configuration"
	echo
}
