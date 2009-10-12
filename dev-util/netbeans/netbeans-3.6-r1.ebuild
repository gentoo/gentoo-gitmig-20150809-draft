# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/netbeans/netbeans-3.6-r1.ebuild,v 1.13 2009/10/12 17:06:09 ssuominen Exp $

inherit eutils

IUSE=""

MY_P=netbeans-${PV/./_}
S=${WORKDIR}/${PN}
DESCRIPTION="NetBeans IDE for Java"
SRC_URI="http://www.netbeans.org/download/release${PV//.}/promoted/FCS/${MY_P}.tar.bz2"
HOMEPAGE="http://www.netbeans.org"

SLOT="0"
LICENSE="GPL-2 Apache-1.1 sun-bcla-j2ee JPython SPL"
KEYWORDS="amd64 ia64 ppc x86"
#still need to add JPython, Sun Public and DynamicJava licenses
#sun-j2ee actually contains Sun Binary Code license
#will have to be renamed and containing it ebuilds updated at spome point..

DEPEND=">=virtual/jdk-1.3
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	# fix jdkhome references
	cd "${S}"/bin
	# runide.sh
	sed -i -e 's:^jdkhome="":jdkhome="`java-config --jdk-home`":' \
		  runide.sh
}

src_install() {
	# remove non-x86 Linux binaries
	rm -f "${S}"/bin/runide*.exe "${S}"/bin/rmid_wrapper.exe
	rm -f "${S}"/bin/runide_exe_defaults
	rm -f "${S}"/bin/runide*.com
	rm -f "${S}"/bin/runideos2.cmd
	rm -f "${S}"/bin/fastjavac/fastjavac.exe
	rm -f "${S}"/bin/fastjavac/fastjavac.sun
	rm -f "${S}"/bin/fastjavac/fastjavac.sun.intel
	rm -f "${S}"/bin/unsupported/*.bat

	# Remove MacOS X Binaries?  This doesn't necessarily make
	# sense because MacOS X could live happily beside Gentoo.
	rm -f "${S}"/bin/macosx_launcher.dmg

	dodir /opt/${P}
	dodoc build_info
	dohtml CHANGES.html CREDITS.html README.html netbeans.css
	# note: docs/ are docs used internally by the IDE
	cp -Rdp ant beans bin \
		docs jakarta-tomcat-5.0.19 \
		lib modules sources \
		system update_tracking "${D}"/opt/${P}
	keepdir /opt/${P}/lib/patches \
		/opt/${P}/modules \
		/opt/netbeans-3.6/jakarta-tomcat-5.0.19/server/classes \
		/opt/netbeans-3.6/jakarta-tomcat-5.0.19/classes \
		/opt/netbeans-3.6/modules/ext/locale
	dodir /usr/bin
	dosym /opt/${P}/bin/runide.sh /usr/bin/netbeans

	doicon "${FILESDIR}"/netbeans.png
}
