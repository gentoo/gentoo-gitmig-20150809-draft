# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/freemind/freemind-0.8.0.ebuild,v 1.2 2006/03/24 08:27:37 lu_zero Exp $

inherit java-pkg eutils

MY_PV=${PV//./_}

DESCRIPTION="Mind-mapping software written in Java"
HOMEPAGE="http://freemind.sf.net"
SRC_URI="mirror://sourceforge/freemind/${PN}-src-${MY_PV/rc2/RC2}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"
RESTRICT="nomirror"

S=${WORKDIR}/${PN}

src_compile() {
	local antflags="dist browser"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} doc"
	ant ${antflags} || die "Compiling failed!"
}

src_install() {
	cd ${WORKDIR}/bin/dist

	insinto /opt/${PN}/
	doins -r lib/ browser/ plugins/
	doins -r accessories/ user.properties patterns.xml

	echo "#!/bin/sh" > ${PN}.sh
	echo "cd /opt/${PN}" >> ${PN}.sh
	echo "java -jar lib/${PN}.jar" >> ${PN}.sh

	cp -R ${S}/doc ${D}/opt/${PN}
	use doc && java-pkg_dohtml -r doc/

	into /opt
	newbin ${PN}.sh ${PN}

	mv ${S}/images/FreeMindWindowIcon.png ${S}/images/freemind.png
	doicon ${S}/images/freemind.png

	make_desktop_entry freemind Freemind freemind.png Utility
}

