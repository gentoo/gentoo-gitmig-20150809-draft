# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/borg/borg-1.7.4.ebuild,v 1.1 2011/01/18 16:51:44 fordfrog Exp $

EAPI="3"
inherit versionator java-pkg-2 java-ant-2

DESCRIPTION="Calendar and task tracker, written in Java"
HOMEPAGE="http://borg-calendar.sourceforge.net/"
MY_PN="${PN}_src"
MY_PV="$(replace_all_version_separators _ )"
SRC_URI="mirror://sourceforge/borg-calendar/${MY_PN}_${MY_PV}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
COMMON_DEP="
	dev-java/sun-javamail:0
	dev-java/javahelp:0"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}
	dev-db/hsqldb:0
	dev-java/jgoodies-looks:2.0"

S="${WORKDIR}/${MY_PN}"
SUBDIR="${S}/BORGCalendar"

EANT_BUILD_XML="${SUBDIR}/ant/build.xml"
EANT_BUILD_TARGET="borg-jar help-jar $(use_doc javadoc)"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Upstream is dead and we already have dev-java/jcalendar
	# but it's not the same thing
	mv "${SUBDIR}"/lib/jcalendar.jar "${T}"
	find -name "*.jar" | xargs rm -fv

	pushd "${SUBDIR}"/lib >/dev/null
	java-pkg_jar-from javahelp
	java-pkg_jar-from sun-javamail
	mv "${T}/jcalendar.jar" . || die
	popd >/dev/null
}

src_install() {
	java-pkg_dojar "${SUBDIR}"/dist/${PN}.jar
	java-pkg_dojar "${SUBDIR}"/build/lib/${PN}help.jar
	java-pkg_dojar "${SUBDIR}"/lib/jcalendar.jar
	java-pkg_register-dependency hsqldb,jgoodies-looks-2.0

	java-pkg_dolauncher ${PN} --main net.sf.borg.control.Borg
}
