# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/projectx/projectx-0.90.4.00_p26.ebuild,v 1.1 2008/12/06 22:46:22 sbriesen Exp $

inherit eutils toolchain-funcs java-pkg-2 java-ant-2

MY_PN="ProjectX"
MY_P="${MY_PN}_Source_${PV%.*}"

# micro-release == 0 ?
#if [ 0${PV##*.} -eq 0 ]; then
#	MY_P="${MY_PN}_Source_${PV%.*}"
#else
#	MY_P="${MY_PN}_Source_${PV}"
#fi

DESCRIPTION="Converts, splits and demuxes DVB and other MPEG recordings"
HOMEPAGE="http://project-x.sourceforge.net/"
SRC_URI="http://sbriesen.de/gentoo/distfiles/${MY_PN}_Source_${PV}.tbz2
	http://sbriesen.de/gentoo/distfiles/${PN}-patches-${PVR}.tbz2
	http://sbriesen.de/gentoo/distfiles/${MY_P}-portable.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="X doc source mmx java5 java6"

COMMON_DEP="dev-java/commons-net
	X? ( =dev-java/browserlauncher2-1* )"

RDEPEND="java6? ( >=virtual/jre-1.6 )
	!java6? ( java5? ( >=virtual/jre-1.5 ) )
	!java6? ( !java5? ( >=virtual/jre-1.4 ) )
	${COMMON_DEP}"

DEPEND="java6? ( >=virtual/jdk-1.6 )
	!java6? ( java5? ( >=virtual/jdk-1.5 ) )
	!java6? ( !java5? ( >=virtual/jdk-1.4 ) )
	${COMMON_DEP}
	app-arch/unzip
	>=sys-apps/sed-4
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
	if use java6; then
		sed 's:\(value=\"\)1\.4\(\"\):\11.6\2:g' \
			"${FILESDIR}/build-${PV%.*}.xml" > build.xml
	elif use java5; then
		sed 's:\(value=\"\)1\.4\(\"\):\11.5\2:g' \
			"${FILESDIR}/build-${PV%.*}.xml" > build.xml
	else
		cp -f "${FILESDIR}/build-${PV%.*}.xml" build.xml
	fi

	# patch location of executable
	sed -i -e "s:^\(Exec=\).*:\1${PN}:g" *.desktop

	# convert CRLF to LF
	edos2unix *.txt MANIFEST.MF

	# convert docs to utf-8
	if [ -x "$(type -p iconv)" ]; then
		for X in zutun.txt; do
			iconv -f LATIN1 -t UTF8 -o "${X}~" "${X}" && mv -f "${X}~" "${X}" || rm -f "${X}~"
		done
	fi

	# apply stdout corruption patch (zzam@gentoo.org)
	epatch "${WORKDIR}/${PN}-stdout-corrupt.diff"

	# apply BrowserLauncher2 patch
	use X && epatch "${WORKDIR}/${PN}-bl2.diff"
	rm -rf src/edu

	# apply idctfast patchset
	sed -i -e "s:IDCTRefNative:IDCTFast:g" src/net/sourceforge/dvb/projectx/video/MpvDecoder.java
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
		CPLAT="${CFLAGS} -O3 -ffast-math -fPIC" || die "emake failed"
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
