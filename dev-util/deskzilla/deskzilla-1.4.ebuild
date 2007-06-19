# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/deskzilla/deskzilla-1.4.ebuild,v 1.1 2007/06/19 13:48:00 caster Exp $

inherit java-pkg-2 versionator

DESCRIPTION="A desktop client for Mozilla's Bugzilla bug tracking system."
HOMEPAGE="http://almworks.com/deskzilla"

MY_PV=$(replace_all_version_separators '_') #${PV/beta/b})
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"
SRC_URI="http://d1.almworks.com/.files/${MY_P}_without_jre.tar.gz"
LICENSE="ALMWorks-1.2"
# license does not allow redistributing, and they seem to silently update
# distfiles...
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=""
RDEPEND=">=virtual/jre-1.5
	~dev-java/picocontainer-1.1
	>=dev-java/jdom-1.0
	>=dev-java/javolution-4.0.2
	>=dev-java/commons-codec-1.3
	>=dev-java/jgoodies-forms-1.0.7
	>=dev-java/commons-logging-1.0.4
	>=dev-java/xmlrpc-2.0.1"

src_unpack() {
	unpack ${A}
	# Remove external unaltered bundled jars
	local lib="${S}/lib"
	local liborig="${S}/lib.orig"
	mv ${lib} ${liborig} || die
	mkdir ${lib} || die
	# They've patched commons-httpclient (was version 3.0)
	mv ${liborig}/commons-httpclient.jar ${lib} || die
	# They've patched nekohtml (was version 0.9.5)
	mv ${liborig}/nekohtml.jar ${lib} || die
	# Almworks proprietary lib
	mv ${liborig}/almworks-tracker-api.jar ${lib} || die
	# IntelliJ IDEA proprietary lib
	mv ${liborig}/forms_rt.jar ${lib} || die
	# God knows what's this. Anyway, proprietary.
	mv ${liborig}/twocents.jar ${lib} || die
	rm -rf ${liborig} || die
}

src_install () {
	local dir=/opt/${P}

	insinto ${dir}
	doins -r components etc license lib log deskzilla.url
	insinto ${dir}/license
	doins ${FILESDIR}/${PN}_gentoo.license

	java-pkg_jarinto ${dir}
	java-pkg_dojar ${PN}.jar
	java-pkg_register-dependency picocontainer-1,jdom-1.0,commons-logging,commons-codec,jgoodies-forms,javolution-4,xmlrpc
	java-pkg_dolauncher ${PN} --main "com.almworks.launcher.Launcher" --java_args "-Xmx256M"

	newdoc README.txt README || die
	newdoc RELEASE.txt RELEASE || die

	doicon deskzilla.png
	make_desktop_entry deskzilla "Deskzilla" deskzilla.png "Development"
}

pkg_postinst() {
	elog "The default, evaluation license allows usage for one month."
	elog "You may switch (per-user) to the license we obtained for Gentoo,"
	elog "located in /opt/${P}/licenses/${PN}_gentoo.license"
	elog "It is locked to Gentoo, ALM Works and Mozilla bugzilla only."
	elog "Note that you need to use 1.5 VM to run deskzilla when setting"
	elog "license or it won't get set due to bug in 1.6+ VMs."
	elog
	elog "If you are going to use Deskzilla for an open source project,"
	elog "you can similarly request your own free license:"
	elog "http://almworks.com/opensource.html?product=deskzilla"
}
