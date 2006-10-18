# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/tvbrowser/tvbrowser-2.2.1.ebuild,v 1.1 2006/10/18 18:16:53 zzam Exp $

inherit eutils java-pkg-2 java-ant-2 autotools flag-o-matic

DESCRIPTION="Themeable and easy to use TV Guide - written in Java"
HOMEPAGE="http://www.tvbrowser.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"

SLOT="0"
KEYWORDS="~x86"

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
	>=dev-java/jgoodies-forms-1.0.7
	>=dev-java/jgoodies-looks-2.0
	dev-java/bsh
	dev-java/skinlf
	dev-java/l2fprod-common"

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
	java-pkg_jar-from jgoodies-forms forms.jar forms-1.0.6.jar
	java-pkg_jar-from jgoodies-looks-2.0 looks.jar looks-2.0.jar
	java-pkg_jar-from bsh bsh.jar bsh-2.0b1.jar
	java-pkg_jar-from skinlf
	java-pkg_jar-from l2fprod-common l2fprod-common-tasks.jar


	cd ${S}/deployment/x11
	rm src/libDesktopIndicator.so
	rm configure

	# converting to unix line-endings
	local f
	for f in missing depcomp; do
		sed -i ${f} -e 's#\r$##'
	done

	eautoreconf
}

src_compile() {
	local antflags="runtime-linux"
	use doc && antflags="${antflags} public-doc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	cd ${S}
	mkdir public
	eant ${antflags}

	# second part: DesktopIndicator
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
	cp -a icons ${D}/${todir}
	cp -a plugins ${D}/${todir}
	cp linux.properties ${D}/${todir}

	mkdir "${D}/usr/share/${PN}-themepacks"
	cp themepacks/themepack.zip "${D}/usr/share/${PN}-themepacks"

	if use themes; then
		cd "${D}/usr/share/${PN}-themepacks"
		unpack allthemepacks.zip
	fi

	java-pkg_dolauncher "tvbrowser" \
		--jar ${todir}/lib/tvbrowser.jar \
		--pwd ${todir}

	cp ${S}/deployment/x11/src/libDesktopIndicator.so ${D}/${todir}
}

pkg_postinst() {
	einfo
	einfo "If you want Systray you have to use a jre >= 1.5 !"
	einfo
}
