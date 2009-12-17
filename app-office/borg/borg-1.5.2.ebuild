# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/borg/borg-1.5.2.ebuild,v 1.4 2009/12/17 10:49:53 ssuominen Exp $

inherit versionator java-pkg-2 java-ant-2

DESCRIPTION="Calendar and task tracker, written in Java"
HOMEPAGE="http://borg-calendar.sourceforge.net/"
MY_PN="${PN}_src"
MY_PV="$(replace_all_version_separators _ )"
SRC_URI="mirror://sourceforge/borg-calendar/${MY_PN}_${MY_PV}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
COMMON_DEP="
	=dev-java/commons-httpclient-3*
	dev-java/sun-javamail
	dev-java/ical4j
	dev-java/javahelp
	dev-java/jdictrayapi
	=dev-java/servletapi-2.4*"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Upstream is dead and we already have dev-java/jcalendar
	# but it's not the same thing
	mv BORGCalendarCommon/lib/jcalendar.jar "${T}"
	rm -v */lib/*.jar || die
	rm -v */*/lib/*.jar || die
	cd BORGCalendarCommon/lib/ || die
	java-pkg_jar-from sun-javamail
	java-pkg_jar-from commons-httpclient-3
	java-pkg_jar-from ical4j
	java-pkg_jar-from javahelp
	java-pkg_jar-from jdictrayapi
	java-pkg_jar-from servletapi-2.4
	mv "${T}/jcalendar.jar" . || die
}

EANT_BUILD_XML="BORGCalendarCommon/ant/build.xml"
EANT_BUILD_TARGET=" "

src_install() {
	java-pkg_dojar ./BORGCalendarCommon/dist/*.jar
	java-pkg_dojar BORGCalendarCommon/lib/jcalendar.jar
	java-pkg_dolauncher ${PN} --main net.sf.borg.control.Borg
}
