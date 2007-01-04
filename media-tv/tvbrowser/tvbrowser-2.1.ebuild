# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/tvbrowser/tvbrowser-2.1.ebuild,v 1.4 2007/01/04 15:54:41 zzam Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils java-pkg flag-o-matic autotools

DESCRIPTION="Themeable and easy to use TV Guide - written in Java"
HOMEPAGE="http://www.tvbrowser.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip
themes? ( http://www.tvbrowser.org/downloads/themepacks/allthemepacks.zip )"

SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="|| ( ( x11-libs/libXt
			x11-libs/libSM
			x11-libs/libICE
			x11-libs/libXext
			x11-libs/libXtst
			x11-libs/libX11
			x11-libs/libXau
			x11-libs/libXdmcp
		)
		virtual/x11
	)
	>=virtual/jre-1.4
	dev-java/junit
	dev-java/commons-net
	dev-java/jgoodies-forms
	dev-java/bsh
	dev-java/skinlf"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	>=dev-java/ant-core-1.5.4
	app-arch/unzip
	source? ( app-arch/zip )"

LICENSE="GPL-2"

IUSE="doc jikes themes source"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-makefiles.patch

	local J_ARCH
	case "${ARCH}" in
		x86)	J_ARCH=i386 ;;
		amd64)	J_ARCH=amd64 ;;
		*) die "not supported arch for this ebuild" ;;
	esac

	sed -i ${S}/deployment/x11/src/Makefile.am \
		-e "s-/lib/i386/-/lib/${J_ARCH}/-"

	cd ${S}/lib
	rm *.jar

	java-pkg_jar-from junit
	java-pkg_jar-from commons-net
	java-pkg_jar-from jgoodies-forms forms.jar forms-1.0.5.jar
	java-pkg_jar-from bsh bsh.jar bsh-2.0b1.jar
	java-pkg_jar-from skinlf

	cd ${S}/deployment/x11
	rm configure

	eautoreconf
}

src_compile() {
	local antflags="runtime-linux"
	use doc && antflags="${antflags} public-doc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	cd ${S}
	mkdir public
	ant ${antflags} || die "compilation failed !"

	# second part: systray-module
	cd ${S}/deployment/x11
	append-flags -fPIC
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	use source && java-pkg_dosrc src/*
	use doc && java-pkg_dohtml -r doc/*
	cd runtime/${PN}_linux

	java-pkg_dojar ${PN}.jar

	local todir="/usr/share/${PN}"
	if [ ${SLOT}q != "0q" ] ; then
		todir="${todir}-${SLOT}"
	fi

	cp -a imgs ${D}/${todir}
	cp -a plugins ${D}/${todir}
	cp linux.properties ${D}/${todir}

	cp libDesktopIndicator.so ${D}/${todir}

	mkdir "${D}/usr/share/${PN}-themepacks"
	cp themepacks/themepack.zip "${D}/usr/share/${PN}-themepacks"

	if use themes; then
		cd "${D}/usr/share/${PN}-themepacks"
		unpack allthemepacks.zip
	fi

	mkdir ${D}/${todir}/bin

	echo "#!/bin/bash" > "${D}/${todir}/bin/tvbrowser.sh"
	echo "cd ${todir}" >> "${D}/${todir}/bin/tvbrowser.sh"
	echo "export LD_LIBRARY_PATH=\${LD_LIBRARY_PATH}:${todir}" >> "${D}/${todir}/bin/tvbrowser.sh"
	echo "\$(java-config -J) -jar lib/tvbrowser.jar" >> "${D}/${todir}/bin/tvbrowser.sh"
	chmod +x "${D}/${todir}/bin/tvbrowser.sh"

	dodir /usr/bin
	dosym ${todir}/bin/tvbrowser.sh /usr/bin/tvbrowser
}

pkg_postinst() {
	einfo
	einfo "If you want Systray you have to use a jre >= 1.5 !"
	einfo
}
