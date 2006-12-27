# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/projectx/projectx-0.90.4.00-r1.ebuild,v 1.3 2006/12/27 13:23:46 corsair Exp $

inherit eutils java-pkg-2 java-ant-2

MY_PN="ProjectX"

# micro-release == 0 ?
if [ 0${PV##*.} -eq 0 ]; then
	MY_P="${MY_PN}_Source_${PV%.*}"
else
	MY_P="${MY_PN}_Source_${PV}"
fi

DESCRIPTION="Converts, splits and demuxes DVB and other MPEG recordings"
HOMEPAGE="http://sourceforge.net/projects/project-x/"
SRC_URI="mirror://sourceforge/project-x/${MY_PN}_Source_eng_${PV}.zip
	mirror://sourceforge/project-x/${MY_PN}_LanguagePack_${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="X doc source"

RDEPEND=">=virtual/jre-1.4
	dev-java/commons-net
	=dev-java/jakarta-oro-2.0*"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	app-arch/unzip
	dev-java/ant-core
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
	java-pkg_jar-from commons-net
	java-pkg_jar-from jakarta-oro-2.0
	java-pkg_ensure-no-bundled-jars
}

src_compile() {
	eant jar $(use_doc docs) -Dmanifest.mainclass=$(mainclass)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	if use X; then
		java-pkg_dolauncher ${PN} --main $(mainclass)
		domenu *.desktop
	else
		java-pkg_dolauncher ${PN} --main $(mainclass) \
			--java_args "-Djava.awt.headless=true"
	fi

	dodoc *.txt
	use doc && java-pkg_dohtml -r apidocs/
	use source && java-pkg_dosrc src/.
}
