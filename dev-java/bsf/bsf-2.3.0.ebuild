# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bsf/bsf-2.3.0.ebuild,v 1.1 2004/04/27 23:26:12 karltk Exp $

inherit java-pkg

DESCRIPTION="Bean Script Framework"
HOMEPAGE="http://jakarta.apache.org/bsf/"
SRC_URI="http://cvs.apache.org/dist/jakarta/bsf/v2.3.0rc1/src/bsf-src-2.3.0.tar.gz"
LICENSE="Apache-1.1"
SLOT="2.3"
KEYWORDS="~x86"
IUSE="doc jikes"
# karltk: Is this really an RDEPEND, or just a CDEPEND?
RDEPEND="=net-www/tomcat-5*"
DEPEND="${REPEND}
	>=dev-java/ant-1.5.4"

S=${WORKDIR}/${P}

src_compile() {
	# karltk: this is dirty. should be fixed when we overhaul tomcat
	# and the entire servlet/java server pages system

	export CLASSPATH=${CLASSPATH}:/opt/tomcat/common/lib/servlet-api.jar
	export CLASSPATH=${CLASSPATH}:/opt/tomcat/common/lib/jsp-api.jar

	local antflags

	# karltk: fix this
#	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	cd src

	ant ${antflags} compile || die
	if use doc ; then
		ant ${antflags} javadocs || die
	fi
}

src_install() {
	java-pkg_dojar src/build/lib/bsf.jar

	use doc && dohtml -r src/build/javadocs/*
}
