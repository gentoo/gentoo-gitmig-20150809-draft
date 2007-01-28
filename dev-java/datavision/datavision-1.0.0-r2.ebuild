# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/datavision/datavision-1.0.0-r2.ebuild,v 1.2 2007/01/28 16:57:22 wltjr Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Open Source reporting tool similar to Crystal Reports"
SRC_URI="mirror://sourceforge/datavision/${P}.tar.gz"
HOMEPAGE="http://datavision.sourceforge.net/"
IUSE="doc mysql postgres ruby"
SLOT="1.0"
LICENSE="Apache-1.1"
KEYWORDS="~x86 ~ppc ~amd64"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/itext-1.02b
	>=dev-java/jcalendar-1.2
	=dev-java/bsf-2.3*
	ruby? ( >=dev-java/jruby-0.7.0 )
	mysql? ( >=dev-java/jdbc-mysql-3.0 )
	postgres? ( >=dev-java/jdbc2-postgresql-7.3 )"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"
#	test? ( >=dev-java/junit-3.7 )"

src_unpack() {
	unpack ${A}
	cd "${S}/lib"

	# lets avoid a new packed jar issue :)
	rm -v *.jar

	java-pkg_jar-from itext
	java-pkg_jar-from bsf-2.3
	java-pkg_jar-from jcalendar-1.2
	use ruby && java-pkg_jar-from jruby

	cd "${S}"
	use mysql && java-pkg_jar-from jdbc-mysql
	use postgres && java-pkg_jar-from jdbc2-postgresql-6
}

#Seems only useful in CVS when there are actually changes to doc sources
#EANT_DOC_TARGET="docs.release"

RESTRICT="test"
#src_test() {
	# Tests need X
	#eant test -Djunit.jar="$(java-pkg_getjars --build-only junit)" \
	#		-Djava.awt.headless=true
#}

src_install() {
	java-pkg_dojar lib/DataVision.jar

	local docdir="/usr/share/doc/${PF}/"
	java-pkg_dolauncher ${PN} \
		--main jimm.datavision.DataVision \
		--pwd ${docdir}

	# Needed for help
	dohtml docs/DataVision/*
	dodir ${docdir}/docs
	dosym ${docdir}/html ${docdir}/docs/DataVision

	dodoc ChangeLog Credits README TODO
	use doc &&	java-pkg_dojavadoc javadoc
}

pkg_postinst() {
	if use mysql; then
		elog
		elog "MySQL example:"
		elog "Driver class name: com.mysql.jdbc.Driver"
		elog "Connection: jdbc:mysql://localhost/database"
	fi

	if use postgres; then
		elog
		elog "PostgreSQL example:"
		elog "Driver class name:org.postgresql.Driver"
		elog "Connection: jdbc:postgresql://localhost/database"
	fi
	elog "Because we need to change the current working directory"
	elog "in the launcher for the help to work, the launcher can't be"
	elog "used with relative paths. Patches are welcome."
}
