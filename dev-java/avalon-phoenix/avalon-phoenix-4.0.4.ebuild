# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-phoenix/avalon-phoenix-4.0.4.ebuild,v 1.3 2003/04/25 22:22:33 tberman Exp $

P=phoenix-${PV}
DESCRIPTION="Avalon Phoenix is a API for java-based servers"
HOMEPAGE="http://avalon.apache.org"
SRC_URI="http://www.apache.org/dist/avalon/phoenix/v${PV}/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"

IUSE="jikes debug"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.5.2"

src_compile() {

	if [ -n "`use jikes`" ]
	then
		echo "build.compiler=jikes\n" > ${S}/.ant.properties
	fi
	if [ -n "`use debug`" ]
	then
		echo "build.debug=on\n" >> ${S}/.ant.properties
	else
		echo "build.debug=off\n" >> ${S}/.ant.properties
	fi
	echo "build.deprecation=off\nbuild.optimize=on" >> ${S}/.ant.properties
	echo 'tools.jar=${java.home}/../j2sdk1.3/lib/tools.jar' >> ${S}/.ant.properties
	echo "phoenix.home=phoenix-home" >> ${S}/.ant.properties
	echo "base.path=/opt" >> ${S}/.ant.properties 	#Is this really needed?

	ant get-mx4j main

}

src_install() {
        dojar dist/bin/lib/*.jar
	dojar dist/bin/phoenix-loader.jar
        dodoc README.txt LICENSE.txt 

        dodir /usr/share/doc/
	dohtml -A .css .jpg .gif -r docs

}
