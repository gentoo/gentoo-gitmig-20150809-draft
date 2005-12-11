# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jbidwatcher/jbidwatcher-0.9.9.ebuild,v 1.2 2005/12/11 23:02:52 nichoj Exp $

inherit java-pkg eutils

MY_PN=JBidWatcher
MY_P=${MY_PN}-${PV}
DESCRIPTION="Java-based eBay bidding, sniping and tracking tool"
HOMEPAGE="http://www.jbidwatcher.com/"
SRC_URI="mirror://sourceforge/jbidwatcher/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd ${S}

	# filed upstream at:
	# http://sf.net/tracker/index.php?func=detail&aid=1334554&group_id=3914&atid=103914
	use doc && epatch "${FILESDIR}/${PN}-0.9.8-javadoc.patch"

	# Fix bad build.xml (used to be the sed magic below)
	epatch "${FILESDIR}/${PN}-0.9.8-build_xml.patch"
#	sed -i -e 's:${user.home}/.jbidwatcher:.:' \
#		-e 's:jikes:modern:' \
#		-e  's:<fileset dir="${src.dir}" includes="jbidwatcher.properties">:<fileset dir="${src.dir}" includes="jbidwatcher.properties" />:' \
#		-e '/taskdef/d' build.xml
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_newjar ${MY_P}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r docs/api

	echo "#!/bin/sh" > ${PN}
	echo 'java -jar $(java-config -p jbidwatcher) "$@"' >> ${PN}

	dobin ${PN}
}
