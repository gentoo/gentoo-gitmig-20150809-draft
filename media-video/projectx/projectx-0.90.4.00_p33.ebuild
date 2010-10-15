# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/projectx/projectx-0.90.4.00_p33.ebuild,v 1.4 2010/10/15 19:10:22 ranger Exp $

EAPI=2

JAVA_PKG_IUSE="doc source"

inherit eutils toolchain-funcs java-pkg-2 java-ant-2

DESCRIPTION="Converts, splits and demuxes DVB and other MPEG recordings"
HOMEPAGE="http://project-x.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/${PN}-portable.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="X mmx"

COMMON_DEP="dev-java/commons-net
	X? ( =dev-java/browserlauncher2-1* )"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.5
	virtual/libiconv
	${COMMON_DEP}"

S=${WORKDIR}/${PN}

mainclass() {
	# read Main-Class from MANIFEST.MF
	sed -n "s/^Main-Class: \([^ ]\+\).*/\1/p" "${S}/MANIFEST.MF" || die
}

java_prepare() {
	# apply stdout corruption patch (zzam@gentoo.org)
	epatch "${FILESDIR}/${P}-stdout-corrupt.patch"

	# apply BrowserLauncher2 patch
	use X && epatch "${FILESDIR}/${P}-bl2.patch"
	rm -rf src/edu || die

	# apply idctfast patchset
	sed -i -e "s:IDCTRefNative:IDCTFast:g" src/net/sourceforge/dvb/projectx/video/MpvDecoder.java || die
	sed -i -e "s:gcc:\$(CC):g" -e "s: -O2::g" lib/PORTABLE/Makefile || die

	# copy build.xml
	cp -f "${FILESDIR}/build-${PV}.xml" build.xml || die

	# patch location of executable
	sed -i -e "s:^\(Exec=\).*:\1${PN}:g" *.desktop || die

	# convert CRLF to LF
	edos2unix *.txt MANIFEST.MF

	# convert docs to utf-8
	if [ -x "$(type -p iconv)" ]; then
		for X in zutun.txt; do
			iconv -f LATIN1 -t UTF8 -o "${X}~" "${X}" && mv -f "${X}~" "${X}" || die
		done
	fi

	# merge/remove resources depending on USE="X"
	if use X; then
		mv -f htmls resources/ || die
	else
		rm -rf src/net/sourceforge/dvb/projectx/gui || die
		rm resources/*.gif || die
	fi

	# update library packages
	cd lib
	rm -f {commons-net,jakarta-oro}*.jar || die
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
		CPLAT="${CFLAGS} -O3 -ffast-math -fPIC" || die
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	java-pkg_doso lib/PORTABLE/libidctfast.so

	java-pkg_dolauncher ${PN}_nogui --main $(mainclass) \
		--java_args "-Djava.awt.headless=true"

	if use X; then
		java-pkg_dolauncher ${PN}_gui --main $(mainclass)
		dosym ${PN}_gui /usr/bin/${PN} || die
		domenu *.desktop || die
	else
		dosym ${PN}_nogui /usr/bin/${PN} || die
	fi

	dodoc *.txt || die
	use doc && java-pkg_dojavadoc apidocs
	use source && java-pkg_dosrc src
}
