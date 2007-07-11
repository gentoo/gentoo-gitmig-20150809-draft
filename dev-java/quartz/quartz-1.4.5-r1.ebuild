# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/quartz/quartz-1.4.5-r1.ebuild,v 1.2 2007/07/11 19:58:38 mr_bones_ Exp $

inherit java-pkg

DESCRIPTION="Quartz Scheduler from OpenSymphony"
HOMEPAGE="http://www.opensymphony.com/quartz/"
SRC_URI="mirror://sourceforge/quartz/${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="dbcp doc jboss jikes jmx jta oracle servlet-2_3 servlet-2_4 struts"
RDEPEND=">=virtual/jre-1.4
		oracle? ( =dev-java/jdbc-oracle-bin-9.2* )
		servlet-2_3? ( >=dev-java/servletapi-2.3 )
		servlet-2_4? ( >=dev-java/servletapi-2.4 )
		dbcp? ( >=dev-java/commons-dbcp-1.1 )
		jboss? ( >=www-servers/jboss-3.2.3 )
		jta? ( >=dev-java/jta-1.0.1 )
		jmx? ( >=dev-java/sun-jmx-1.2.1 )
		struts? ( =dev-java/struts-1.1* )
		jikes? ( dev-java/jikes )"

DEPEND=">=virtual/jdk-1.4
		${RDEPEND}
		dev-java/ant
		app-arch/unzip"

src_compile() {
	local antflags=""
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	use servlet-2_3 && CLASSPATH="$CLASSPATH:$(java-pkg_getjars servletapi-2.3)"
	use servlet-2_4 && CLASSPATH="$CLASSPATH:$(java-pkg_getjars servletapi-2.4)"
	use dbcp && CLASSPATH="$CLASSPATH:$(java-pkg_getjars commons-dbcp)"
	use jta && CLASSPATH="$CLASSPATH:$(java-pkg_getjars jta)"
	use oracle && CLASSPATH="$CLASSPATH:$(java-pkg_getjars jdbc-oracle-bin-9.2)"
	if use jboss; then
		cp /usr/share/jboss/lib/jboss-common.jar ${S}/lib
		cp /usr/share/jboss/lib/jboss-jmx.jar ${S}/lib
		cp /usr/share/jboss/lib/jboss-system.jar ${S}/lib
		cp /var/lib/jboss/default/lib/jboss.jar ${S}/lib
		antflags="${antflags} -Dlib.jboss-common.jar=/usr/share/jboss/lib/jboss-common.jar"
		antflags="${antflags} -Dlib.jboss-jmx.jar=/usr/share/jboss/lib/jboss-jmx.jar"
		antflags="${antflags} -Dlib.jboss-system.jar=/usr/share/jboss/lib/jboss-system.jar"
		antflags="${antflags} -Dlib.jboss.jar=/var/lib/jboss/default/lib/jboss.jar"
	fi
	use struts && CLASSPATH="$CLASSPATH:$(java-pkg_getjars struts-1.1)"

	antflags="${antflags} compile jar"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar lib/quartz.jar
	use doc && java-pkg_dohtml -r docs/
}
