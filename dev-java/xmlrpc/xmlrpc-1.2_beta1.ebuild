# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmlrpc/xmlrpc-1.2_beta1.ebuild,v 1.1 2004/07/25 07:49:49 mkennedy Exp $

inherit java-pkg

MY_PV=${PV/_beta/-b}

DESCRIPTION="Apache XML-RPC is a Java implementation of XML-RPC"
HOMEPAGE="http://ws.apache.org/xmlrpc/"
SRC_URI="http://www.apache.org/dist/ws/xmlrpc/v${MY_PV}/${PN}-${MY_PV}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="jikes doc"
DEPEND="dev-java/ant"

S=${WORKDIR}/${PN}-${MY_PV}

src_compile() {
	local ant_options='-Dbuild.dir=build
		-Dbuild.dest=dest
		-Dsrc.dir=src
		-Djavadoc.destdir=api'
	use jikes && ant_options="${ant_options} -Dbuild.compiler=jikes"
	# Our friends at ws.apache.org actually forgot to include
	# build.properties in the source archive??
	ant ${ant_options} \
		-Dfinal.name=xmlrpc-${MY_PV} \
		|| die
	if use doc; then
		ant ${ant_options} \
			javadocs \
			|| die
	fi
}

src_install() {
	java-pkg_dojar build/xmlrpc-${MY_PV}*.jar || die
	dodoc *.txt
	use doc && dohtml -r api
}

pkg_postinst() {
	while read line; do einfo "${line}"; done <<'EOF'

This port does not build Servlet and/or SSL extensions.	 This port
does not provide examples examples either.	Refer to README.txt for
more details on this.

EOF
}
