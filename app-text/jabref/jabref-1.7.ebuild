# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jabref/jabref-1.7.ebuild,v 1.3 2005/04/03 10:18:48 sejo Exp $

inherit java-pkg eutils

DESCRIPTION="GUI frontend for BibTeX, written in Java"
HOMEPAGE="http://jabref.sourceforge.net/"
SRC_URI="mirror://sourceforge/jabref/JabRef-${PV}-src.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="jikes"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.4.1
	jikes? ( dev-java/jikes )
	dev-java/junit"
RDEPEND=">=virtual/jre-1.4
	dev-java/spin
	>=dev-java/antlr-2.7.3
	~dev-java/jgoodies-forms-1.0.5
	=dev-java/jgoodies-looks-1.2*
	>=dev-java/commons-logging-1.0.4
	>=dev-java/commons-httpclient-2"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-nojarbundler.patch

	cd ${S}/lib && rm -f *.jar
	java-pkg_jar-from antlr
	java-pkg_jar-from spin
	java-pkg_jar-from jgoodies-looks-1.2 looks.jar
	java-pkg_jar-from jgoodies-forms forms-1.0.5.jar forms.jar
	java-pkg_jar-from commons-logging commons-logging.jar
	java-pkg_jar-from commons-httpclient commons-httpclient.jar
}


src_compile() {
	local antflags="compile unjarlib jars"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar build/lib/${PN}.jar

	echo "#!/bin/sh" > ${PN}
	echo '$(java-config -J) -jar $(java-config -p jabref)' '$*' >> ${PN}

	dobin ${PN}
}
