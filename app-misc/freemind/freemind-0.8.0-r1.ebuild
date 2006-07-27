# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/freemind/freemind-0.8.0-r1.ebuild,v 1.1 2006/07/27 14:58:02 nichoj Exp $

inherit java-pkg-2 java-ant-2 eutils

MY_PV=${PV//./_}

DESCRIPTION="Mind-mapping software written in Java"
HOMEPAGE="http://freemind.sf.net"
SRC_URI="mirror://sourceforge/freemind/${PN}-src-${MY_PV/rc2/RC2}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
# FIXME doesn't like compiling with Java 1.6 for some reason
DEPEND="|| (
		=virtual/jdk-1.4*
		=virtual/jdk-1.5*
	)
	dev-java/ant-core
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"
RESTRICT="nomirror"

S=${WORKDIR}/${PN}

src_compile() {
	eant dist browser $(use_doc doc)
}

src_install() {
	cd ${WORKDIR}/bin/dist

	insinto /opt/${PN}/
	doins -r lib/ browser/ plugins/
	doins -r accessories/ user.properties patterns.xml

	java-pkg_regjar /opt/${PN}/lib/${PN}.jar

	java-pkg_dolauncher ${PN} --jar /opt/${PN}/lib/${PN}.jar

	cp -R ${S}/doc ${D}/opt/${PN}
	use doc && java-pkg_dohtml -r doc/

	into /opt
	newbin ${PN}.sh ${PN}

	mv ${S}/images/FreeMindWindowIcon.png ${S}/images/freemind.png
	doicon ${S}/images/freemind.png

	make_desktop_entry freemind Freemind freemind.png Utility
}

