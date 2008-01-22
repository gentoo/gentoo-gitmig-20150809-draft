# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/tvbrowser/tvbrowser-2.6.3.ebuild,v 1.1 2008/01/22 00:05:15 caster Exp $

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2 autotools flag-o-matic

DESCRIPTION="Themeable and easy to use TV Guide - written in Java"
HOMEPAGE="http://www.tvbrowser.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip
themes? (
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/midnightthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/roueBrownthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/roueBluethemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/roueGreenthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/blueTurquesathemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/gorillathemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/BeOSthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/crystal2themepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/opusOSDeepthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/chaNinja-Bluethemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/amarachthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/quickSilverRthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/gfxOasisthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/underlingthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/coronaHthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/cougarthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/royalInspiratthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/tigerthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/mmMagra-Xthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/iBarthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/solunaRthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/fatalEthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/blueMetalthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/b0sumithemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/b0sumiErgothempack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/oliveGreenLunaXPthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/silverLunaXPthemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/architectBluethemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/architectOlivethemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/hmmXPBluethemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/hmmXPMonoBluethemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/tigerGraphitethemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/opusOSBluethemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/opusOSOlivethemepack.zip
http://javootoo.l2fprod.com/plaf/skinlf/t-packs/themepacks/opusLunaSilverthemepack.zip
http://www.tvbrowser.org/downloads/CrystalClear.zip
http://www.tvbrowser.org/downloads/noia.zip
http://www.tvbrowser.org/downloads/nuvola.zip
http://www.tvbrowser.org/downloads/tulliana.zip
)"

SLOT="0"
KEYWORDS="~x86 ~amd64"

COMMON_DEP="x11-libs/libXt
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libXext
	x11-libs/libXtst
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	dev-java/junit
	dev-java/commons-codec
	dev-java/commons-net
	>=dev-java/jgoodies-forms-1.1.0
	>=dev-java/jgoodies-looks-2.0
	dev-java/bsh
	dev-java/l2fprod-common
	>=dev-java/jakarta-oro-2.0
	dev-java/skinlf"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

LICENSE="GPL-2"

IUSE="themes"

src_unpack() {
	unpack ${P}-src.zip
	cd "${S}"

	epatch "${FILESDIR}/tvbrowser-2.5-makefiles.patch"

	# fix bug #170363
	epatch "${FILESDIR}/tvbrowser-2.6._Localizer.patch"

	# now that's a rather nasty trick that removes exactly the lines that unjar
	# dependencies and include them to tvbrowser's jars
	# when bumping, check that it doesn't affect lines it shouldn't!
	sed "/unpacked.dir/d" -i build.xml || die

	local J_ARCH
	case "${ARCH}" in
		x86)	J_ARCH=i386 ;;
		amd64)	J_ARCH=amd64 ;;
		*) die "not supported arch for this ebuild" ;;
	esac

	sed -i "${S}"/deployment/x11/src/Makefile.am \
		-e "s:/lib/i386/:/lib/${J_ARCH}/:" || die

	# who knows what were those for
	rm -v "${S}"/tvdatakit/workspace/lib/*.jar || die

	cd "${S}"/lib || die
	rm -v junit.jar commons-net-1.4.1.jar forms-1.1.0.jar looks-2.1.4.jar \
		bsh-2.0b4.jar l2fprod-common-tasks.jar jakarta-oro-2.0.8.jar skinlf.jar \
		commons-codec-1.3.jar || die

	# missing dependencies commons-compress, TVAnytimeAPI, jRegistryKey, gdata-calendar, gdata-client and jcom
	# use local jar files for these, and also those in deployment
	# some are win32/mac only, so we will let tvbrowser build against them (no need to patch stuff out of sources)
	# but won't install the bundled jars, because their codepath won't be executed on linux anyway
	java-pkg_jar-from junit,commons-codec,commons-net,jgoodies-forms,jgoodies-looks-2.0,bsh,l2fprod-common,skinlf

	# Fails to create javadocs without this
	mkdir "${S}/public" || die

	# fix bug #170364
	cd "${S}/deployment/x11"
	chmod u+x configure
	rm src/libDesktopIndicator.so

	# converting to unix line-endings
	edos2unix missing depcomp

	eautoreconf
}

src_compile() {
	eant runtime-linux $(use_doc public-doc)

	# second part: DesktopIndicator
	cd "${S}/deployment/x11"

	append-flags -fPIC
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	use source && java-pkg_dosrc src/*
	use doc && java-pkg_dojavadoc doc
	cd runtime/${PN}_linux || die

	java-pkg_dojar ${PN}.jar
	java-pkg_dojar "${S}"/lib/{TVAnytimeAPI.jar,commons-compress-20050911.jar,gdata-calendar-1.0.jar,gdata-client-1.0.jar,gdata-core-1.0.jar}

	local todir="${JAVA_PKG_SHAREPATH}"

	cp -a imgs "${D}/${todir}" || die
	cp -a icons "${D}/${todir}" || die
	cp -a plugins "${D}/${todir}" || die
	cp linux.properties "${D}/${todir}" || die

	insinto "${todir}/themepacks"
	doins themepacks/themepack.zip || die

	if use themes; then
		cd "${DISTDIR}"
		doins midnightthemepack.zip \
			roueBrownthemepack.zip \
			roueBluethemepack.zip \
			roueGreenthemepack.zip \
			blueTurquesathemepack.zip \
			gorillathemepack.zip \
			BeOSthemepack.zip \
			crystal2themepack.zip \
			opusOSDeepthemepack.zip \
			chaNinja-Bluethemepack.zip \
			amarachthemepack.zip \
			quickSilverRthemepack.zip \
			gfxOasisthemepack.zip \
			underlingthemepack.zip \
			coronaHthemepack.zip \
			cougarthemepack.zip \
			royalInspiratthemepack.zip \
			tigerthemepack.zip \
			mmMagra-Xthemepack.zip \
			iBarthemepack.zip \
			solunaRthemepack.zip \
			fatalEthemepack.zip \
			blueMetalthemepack.zip \
			b0sumithemepack.zip \
			b0sumiErgothempack.zip \
			oliveGreenLunaXPthemepack.zip \
			silverLunaXPthemepack.zip \
			architectBluethemepack.zip \
			architectOlivethemepack.zip \
			hmmXPBluethemepack.zip \
			hmmXPMonoBluethemepack.zip \
			tigerGraphitethemepack.zip \
			opusOSBluethemepack.zip \
			opusOSOlivethemepack.zip \
			opusLunaSilverthemepack.zip || die
		insinto "${todir}/icons"
		doins CrystalClear.zip noia.zip nuvola.zip tulliana.zip || die
	fi

	java-pkg_doso "${S}/deployment/x11/src/libDesktopIndicator.so"

	java-pkg_dolauncher "tvbrowser" \
		--main tvbrowser.TVBrowser \
		--pwd ${todir} \
		--java_args " -Dpropertiesfile=${todir}/linux.properties"

	make_desktop_entry ${PN} "TV Browser" /usr/share/tvbrowser/imgs/tvbrowser128.png
}
