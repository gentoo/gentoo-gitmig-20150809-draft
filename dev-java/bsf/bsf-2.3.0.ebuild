# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bsf/bsf-2.3.0.ebuild,v 1.5 2004/08/08 21:20:19 stuart Exp $

inherit java-pkg

DESCRIPTION="Bean Script Framework"
HOMEPAGE="http://jakarta.apache.org/bsf/"
SRC_URI="http://cvs.apache.org/dist/jakarta/bsf/v2.3.0rc1/src/bsf-src-2.3.0.tar.gz"
LICENSE="Apache-1.1"
SLOT="2.3"
KEYWORDS="~x86"
IUSE="doc"
# karltk: Is this really an RDEPEND, or just a CDEPEND?
RDEPEND="=www-servers/tomcat-5*"
DEPEND="${REPEND}
	>=dev-java/ant-1.5.4"

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
