# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/tvbrowser/tvbrowser-2.5.2.ebuild,v 1.1 2007/03/27 13:46:50 zzam Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils java-pkg-2 java-ant-2 autotools flag-o-matic

DESCRIPTION="Themeable and easy to use TV Guide - written in Java"
HOMEPAGE="http://www.tvbrowser.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip
themes? ( http://www.tvbrowser.org/downloads/themepacks/allthemepacks.zip )"

SLOT="0"
KEYWORDS="~x86 ~amd64"

# missing dependencies commons-compress, TVAnytimeAPI, jRegistryKey , gdata-calendar, gdata-client and jcom

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
	>=virtual/jre-1.5
	dev-java/junit
	dev-java/commons-net
	>=dev-java/jgoodies-forms-1.0.7
	>=dev-java/jgoodies-looks-2.0
	>=dev-java/bsh-2.0_beta1
	dev-java/skinlf
	dev-java/l2fprod-common
	>=dev-java/poi-2.5.1
	>=dev-java/xerces-2.6.2"

DEPEND=">=virtual/jdk-1.5
	${RDEPEND}
	>=dev-java/ant-core-1.5.4
	app-arch/unzip
	source? ( app-arch/zip )"

LICENSE="GPL-2"

IUSE="doc themes source"

src_unpack() {
	unpack ${P}-src.zip

	cd ${S}
	epatch ${FILESDIR}/tvbrowser-2.5-makefiles.patch
	epatch ${FILESDIR}/${P}_noWin32.patch
	epatch ${FILESDIR}/${P}_buildxml.patch

	#fix bug #170363
	epatch ${FILESDIR}/tvbrowser-2.5_Localizer.patch

	# missing commons-compress, gdata-calendar, gdata-client
	rm -r ${S}/src/calendarexportplugin
	rm -r ${S}/src/bbcbackstagedataservice

	#we don't need this stuff
	rm -r ${S}/deployment/win
	rm -r ${S}/deployment/macosx

	local J_ARCH
	case "${ARCH}" in
		x86)	J_ARCH=i386 ;;
		amd64)	J_ARCH=amd64 ;;
		*) die "not supported arch for this ebuild" ;;
	esac

	sed -i ${S}/deployment/x11/src/Makefile.am \
		-e "s-/lib/i386/-/lib/${J_ARCH}/-"

	cd ${S}/tvdatakit/workspace/lib
	rm *.jar

	java-pkg_jar-from poi
	java-pkg_jar-from xerces-2

	cd ${S}/lib
	rm *.jar

	java-pkg_jar-from junit
	java-pkg_jar-from commons-net
	java-pkg_jar-from jgoodies-forms forms.jar forms-1.0.7.jar
	java-pkg_jar-from jgoodies-looks-2.0 looks.jar looks-2.0.4.jar
	java-pkg_jar-from bsh bsh.jar bsh-2.0b1.jar
	java-pkg_jar-from skinlf
	java-pkg_jar-from l2fprod-common l2fprod-common-tasks.jar

	#fix bug #170364
	cd ${S}/deployment/x11
	chmod u+x configure
	rm src/libDesktopIndicator.so

	# converting to unix line-endings
	edos2unix missing depcomp

	eautoreconf
}

src_compile() {
	local antflags="runtime-linux"
	use doc && antflags="${antflags} public-doc"
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

	insinto "/usr/share/${PN}/themepacks"
	doins themepacks/themepack.zip

	if use themes; then
		cd "${D}/usr/share/${PN}/themepacks"
		unpack allthemepacks.zip
	fi

	java-pkg_doso ${S}/deployment/x11/src/libDesktopIndicator.so

	java-pkg_dolauncher "tvbrowser" \
		--jar ${todir}/lib/tvbrowser.jar \
		--pwd ${todir} \
		--java_args " -Dpropertiesfile=${todir}/linux.properties"
}

pkg_postinst() {
	elog
	elog "If you want Systray you have to use a jre >= 1.5 !"
	elog
}
