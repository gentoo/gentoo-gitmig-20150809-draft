# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/projectx/projectx-0.90.4.00.ebuild,v 1.2 2006/12/27 13:23:46 corsair Exp $

inherit eutils java-pkg

MY_PN="ProjectX"

# micro-release == 0 ?
if [ 0${PV##*.} -eq 0 ]; then
	MY_P="${MY_PN}_Source_${PV%.*}"
else
	MY_P="${MY_PN}_Source_${PV}"
fi

JAVA_OPTS="-Xms32m -Xmx512m"
CLASS_PATH="projectx,commons-net,jakarta-oro-2.0"

DESCRIPTION="Converts, splits and demuxes DVB and other MPEG recordings"
HOMEPAGE="http://sourceforge.net/projects/project-x/"
SRC_URI="mirror://sourceforge/project-x/${MY_PN}_Source_eng_${PV}.zip
	mirror://sourceforge/project-x/${MY_PN}_LanguagePack_${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.4
	dev-java/commons-net
	=dev-java/jakarta-oro-2.0*"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	app-arch/unzip
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

S="${WORKDIR}/${MY_P}"

mainclass() {
	# read Main-Class from MANIFEST.MF
	sed -n "s/^Main-Class: \([^ ]\+\).*/\1/p" "${S}/MANIFEST.MF"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# copy build.xml
	cp -f "${FILESDIR}/build-${PV%.*}.xml" build.xml

	# patch location of executable
	sed -i -e "s:^\(Exec=\).*:\1${PN}:g" *.desktop

	# convert CRLF to LF
	edos2unix *.txt MANIFEST.MF

	# update library packages	
	cd lib
	rm -f {commons-net,jakarta-oro}*.jar
	java-pkg_jar-from jakarta-oro-2.0
	java-pkg_jar-from commons-net
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	antflags="${antflags} -Dmanifest.mainclass=$(mainclass)"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	# generate a startup script
	echo "#!/bin/sh" > ${PN}
	echo "exec \$(java-config -J) ${JAVA_OPTS} -cp \$(java-config -p ${CLASS_PATH}) $(mainclass) \"\$@\"" >> ${PN}

	dobin ${PN}
	dodoc *.txt
	domenu *.desktop

	use doc && java-pkg_dohtml -r apidocs/
	use source && java-pkg_dosrc src/*
}
