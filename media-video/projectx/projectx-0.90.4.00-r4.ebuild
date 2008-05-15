# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/projectx/projectx-0.90.4.00-r4.ebuild,v 1.1 2008/05/15 08:49:16 zzam Exp $

inherit eutils toolchain-funcs java-pkg-2 java-ant-2

MY_PN="ProjectX"

# micro-release == 0 ?
if [ 0${PV##*.} -eq 0 ]; then
	MY_P="${MY_PN}_Source_${PV%.*}"
else
	MY_P="${MY_PN}_Source_${PV}"
fi

DESCRIPTION="Converts, splits and demuxes DVB and other MPEG recordings"
HOMEPAGE="http://project-x.sourceforge.net/"
SRC_URI="mirror://sourceforge/project-x/${MY_PN}_Source_eng_${PV}.zip
	mirror://sourceforge/project-x/${MY_PN}_LanguagePack_${PV}.zip
	http://sbriesen.de/gentoo/distfiles/${PN}-patches-${PVR}.tbz2
	http://sbriesen.de/gentoo/distfiles/${MY_P}-portable.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="X doc source mmx"

COMMON_DEP="dev-java/commons-net
	X? ( =dev-java/browserlauncher2-1* )"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}
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

	# apply subtitle clut patch
	epatch "${WORKDIR}/${PN}-${PV%.*}-clut.diff"

	# apply subtitle charset patch
	epatch "${WORKDIR}/${PN}-${PV%.*}-charset.diff"

	# apply BrowserLauncher2 patch
	use X && epatch "${WORKDIR}/${PN}-${PV%.*}-bl2.diff"
	rm -rf src/edu

	epatch "${FILESDIR}/${P}-stdout-corrupt.diff"

	# cleanup idctfast patchset
	rm -f lib/PORTABLE/*.{o,so}
	rm -f src/net/sourceforge/dvb/projectx/video/IDCT{Ref,Sse}Native.java
	sed -i -e "s:gcc:\$(CC):g" -e "s: -O2::g" lib/PORTABLE/Makefile

	# merge/remove resources depending on USE="X"
	if use X; then
		mv -f htmls resources/
	else
		rm -rf src/net/sourceforge/dvb/projectx/gui
		rm resources/*.gif
	fi

	# update library packages
	cd lib
	rm -f {commons-net,jakarta-oro}*.jar
	java-pkg_jar-from commons-net
	use X && java-pkg_jar-from browserlauncher2-1.0
	java-pkg_ensure-no-bundled-jars
}

src_compile() {
	local IDCT="idct-mjpeg"  # default IDCT implementation
	use x86 && use mmx && IDCT="idct-mjpeg-mmx"

	eant build $(use_doc) -Dmanifest.mainclass=$(mainclass)

	cd lib/PORTABLE
	emake CC=$(tc-getCC) IDCT="${IDCT}" LDFLAGS="${LDFLAGS}" \
		CPLAT="${CFLAGS} -ffast-math -fPIC" || die "emake failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	java-pkg_doso lib/PORTABLE/libidctfast.so

	java-pkg_dolauncher ${PN}_nogui --main $(mainclass) \
		--java_args "-Djava.awt.headless=true"

	if use X; then
		java-pkg_dolauncher ${PN}_gui --main $(mainclass)
		dosym ${PN}_gui /usr/bin/${PN}
		domenu *.desktop
	else
		dosym ${PN}_nogui /usr/bin/${PN}
	fi

	dodoc *.txt
	use doc && java-pkg_dojavadoc apidocs
	use source && java-pkg_dosrc src
}
