# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/projectx/projectx-0.90.4.00_p33-r1.ebuild,v 1.2 2010/08/02 02:24:00 mr_bones_ Exp $

EAPI="3"

JAVA_PKG_IUSE="doc source"

inherit eutils toolchain-funcs java-pkg-2 java-ant-2

XDG_P="xdg-20100731"

DESCRIPTION="Converts, splits and demuxes DVB and other MPEG recordings"
HOMEPAGE="http://project-x.sourceforge.net/"
SRC_URI="http://sbriesen.de/gentoo/distfiles/${P}.tar.xz
	http://sbriesen.de/gentoo/distfiles/${PN}-idctfast.tar.xz
	http://sbriesen.de/gentoo/distfiles/${XDG_P}.java.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="X mmx sse"

COMMON_DEP="dev-java/commons-net
	X? ( =dev-java/browserlauncher2-1* )"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.5
	virtual/libiconv
	${COMMON_DEP}"

S="${WORKDIR}/Project-X"

mainclass() {
	# read Main-Class from MANIFEST.MF
	sed -n "s/^Main-Class: \([^ ]\+\).*/\1/p" "${S}/MANIFEST.MF" || die
}

java_prepare() {
	local X

	# apply stdout corruption patch (zzam@gentoo.org)
	epatch "${FILESDIR}/${P}-stdout-corrupt.patch"

	# apply BrowserLauncher2 patch
	use X && epatch "${FILESDIR}/${P}-bl2.patch"
	rm -rf src/edu || die

	# apply IDCTFast patch
	epatch "${FILESDIR}/${P}-idctfast.patch"

	# apply XDG patch
	cp -f "${WORKDIR}/${XDG_P}.java" "${S}/src/xdg.java"
	epatch "${FILESDIR}/${P}-xdg.patch"

	# copy build.xml
	cp -f "${FILESDIR}/build-${PV}.xml" build.xml || die

	# patch executable and icon
	sed -i -e "s:^\(Exec=\).*:\1${PN}_gui:g" \
		-e "s:^\(Icon=\).*:\1${PN}:g" *.desktop || die

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
	if use x86 || use amd64; then
		use mmx && IDCT="idct-mjpeg-mmx"
		use sse && IDCT="idct-mjpeg-sse"
	fi

	eant build $(use_doc) -Dmanifest.mainclass=$(mainclass)

	cd lib/PORTABLE
	emake CC=$(tc-getCC) IDCT="${IDCT}" LDFLAGS="${LDFLAGS}" \
		CPLAT="${CFLAGS} -O3 -ffast-math -fPIC" || die
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	java-pkg_doso lib/PORTABLE/libidctfast.so

	java-pkg_dolauncher ${PN}_cli --main $(mainclass) \
		--java_args "-Djava.awt.headless=true -Xmx256m"

	# compatibility symlink, should be removed
	dosym ${PN}_cli /usr/bin/${PN}_nogui || die

	if use X; then
		java-pkg_dolauncher ${PN}_gui --main $(mainclass) \
			--java_args "-Xmx256m"
		dosym ${PN}_gui /usr/bin/${PN} || die
		newicon "${FILESDIR}/icon.png" "${PN}.png"
		domenu *.desktop || die
	else
		dosym ${PN}_cli /usr/bin/${PN} || die
	fi

	dodoc *.txt || die
	use doc && java-pkg_dojavadoc apidocs
	use source && java-pkg_dosrc src
}

pkg_postinst() {
	elog "Default config file and location has changed!"
	elog
	elog "It is now located at \$XDG_CONFIG_HOME/Project-X.ini"
	elog "You should move your old X.ini into the new location."
	elog
	elog "Hint: \$XDG_CONFIG_HOME defaults to ~/.config"
}
