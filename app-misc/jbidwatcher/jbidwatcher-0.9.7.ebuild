# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jbidwatcher/jbidwatcher-0.9.7.ebuild,v 1.1 2005/07/03 09:52:28 axxo Exp $

inherit java-pkg

DESCRIPTION="Ebay Bidder Tools for Sniping"
HOMEPAGE="http://jbidwatcher.sf.net/"
SRC_URI="mirror://sourceforge/jbidwatcher/${P/_/}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE="jikes"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${P/_/}

src_compile() {
	sed -i 's:${user.home}/.jbidwatcher:.:' build.xml
	sed -i 's:jikes:modern:' build.xml
	# Fix bad build.xml
	sed -i 's:<fileset dir="${src.dir}" includes="jbidwatcher.properties">:<fileset dir="${src.dir}" includes="jbidwatcher.properties" />:' build.xml
	sed -i '/taskdef/d' build.xml

	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_newjar *.jar ${PN}.jar

	echo "#!/bin/sh" > ${PN}
	echo '$(java-config -J) -jar $(java-config -p jbidwatcher) $*' >> ${PN}

	dobin ${PN}
}
