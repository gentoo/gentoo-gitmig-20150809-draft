# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/fujaba/fujaba-4.2.0.ebuild,v 1.2 2005/02/06 15:39:50 luckyduck Exp $

MY_PV="${PV//./_}"
MY_PNB="Fujaba_${PV:0:1}"

DESCRIPTION="The Fujaba Tool Suite provides an easy to extend UML and Java development platform"
HOMEPAGE="http://www.uni-paderborn.de/cs/fujaba/index.html"
SRC_URI="ftp://ftp.uni-paderborn.de/private/fujaba/${MY_PNB}/FujabaToolSuite_Developer${MY_PV}.jar"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/java-config
	dev-java/junit
	dev-java/log4j
	~dev-java/jdom-1.0_beta10"

S=${WORKDIR}

src_unpack () {
	unzip ${DISTDIR}/${A} >/dev/null || die "failed to unpack"
}

src_compile() { :; }

src_install() {
	dodir /opt/${PN}
	cd 'C_/Dokumente und Einstellungen/Lothar/Eigene Dateien/Deployment/Fujaba 4.2.0/' || die "failed to enter die"

	rm -f Deploymentdata/libs/junit.jar
	rm -f Deploymentdata/libs/log4j.jar
	rm -f Deploymentdata/libs/jdom.jar

	cp -a . ${D}/opt/${PN} || die "failed too copy"
	chmod -R 755 ${D}/opt/${PN}/

	echo "#!/bin/sh" > ${PN}
	echo "cd /opt/${PN}/Deploymentdata" >> ${PN}
	#jdom and java-config doesn't seem to get along
	echo "'${JAVA_HOME}'/bin/java -classpath .:\$(java-config -p log4j,junit,jdom-1.0_beta10) -jar ${PN}.jar \$*" >> ${PN}

	into /opt
	dobin ${PN}
}
