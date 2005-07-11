# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jbidwatcher/jbidwatcher-0.9.7.ebuild,v 1.2 2005/07/11 20:37:23 axxo Exp $

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

src_unpack() {
	unpack ${A}
	cd ${S}
	# Fix bad build.xml
	sed -i -e 's:${user.home}/.jbidwatcher:.:' \
		-e 's:jikes:modern:' \
		-e  's:<fileset dir="${src.dir}" includes="jbidwatcher.properties">:<fileset dir="${src.dir}" includes="jbidwatcher.properties" />:' \
		-e '/taskdef/d' build.xml
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_newjar *.jar ${PN}.jar

	echo "#!/bin/sh" > ${PN}
	echo 'java -jar $(java-config -p jbidwatcher) "$@"' >> ${PN}

	dobin ${PN}
}
