# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/aolserver.eclass,v 1.8 2005/07/11 15:08:06 swegener Exp $

# Authors:
#	Ian Leitch <port001@gentoo.org>

EXPORT_FUNCTIONS src_compile src_install pkg_postinst

DEPEND="www-servers/aolserver"
RDEPEND="${DEPEND}"

NS_CONF="/usr/share/aolserver" # /include/ is implied by the Makefile
NS_BASE="/usr/lib/aolserver"

SRC_URI="mirror://sourceforge/aolserver/${P}.tar.gz"
HOMEPAGE="http://www.aolserver.com"
LICENSE="MPL-1.1"
SLOT="0"

aolserver_src_compile() {

	emake NSBUILD=1 INST=${NS_CONF} AOLSERVER=${NS_CONF} ${MAKE_FLAGS} || die "emake failed"
}

aolserver_src_install() {

	find ${S} -type d -name CVS -prune | xargs rm -rf

	into ${NS_BASE}

	if [[ -e "${S}/${PN}.so" ]] ; then
		dobin ${S}/${PN}.so
	fi

	if [[ -e "${S}/lib${PN}.so" ]] ; then
		dolib.so ${S}/lib${PN}.so
	fi

	for mod in ${TCL_MODS} ; do
		insinto /usr/lib/aolserver/modules/tcl
		doins ${mod}
	done

	for doc in ${DOCS} ; do
		dodoc ${doc}
	done
}

aolserver_pkg_postinst() {

	echo
	einfo "To enable the use of ${PN} you must add the module to your AOLServer configuration"
	echo
}
