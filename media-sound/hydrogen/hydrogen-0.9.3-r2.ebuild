# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/hydrogen/hydrogen-0.9.3-r2.ebuild,v 1.3 2007/09/04 22:06:16 jurek Exp $

inherit eutils kde-functions autotools multilib

DESCRIPTION="Linux Drum Machine"
HOMEPAGE="http://hydrogen.sourceforge.net/"
SRC_URI="mirror://sourceforge/hydrogen/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc x86"
IUSE="alsa debug doc flac jack ladspa oss portaudio"

RDEPEND="dev-libs/libxml2
	media-libs/libsndfile
	media-libs/audiofile
	flac? ( media-libs/flac )
	portaudio? ( media-libs/portaudio )
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	ladspa? ( media-libs/liblrdf )"

DEPEND="${RDEPEND}
	doc? ( app-text/docbook-sgml-utils )"

need-qt 3

pkg_setup() {
	if use alsa && ! built_with_use --missing true media-libs/alsa-lib midi; then
		eerror ""
		eerror "To be able to build ${CATEGORY}/${PN} with ALSA support you"
		eerror "need to have built media-libs/alsa-lib with midi USE flag."
		die "Missing midi USE flag on media-libs/alsa-lib"
	fi
}

src_unpack() {
	unpack ${A}
	if use ppc; then
		cd "${S}/src"
		epatch "${FILESDIR}/0.9.1-OSS.patch" || die "patching failed"
	fi
	cd "${S}"

	mv data/doc/man "${S}"
	# broken or portability issue
	find . -iname Makefile.in -exec sed -i -e "s:update-menus::" {} \;
	# find PortAudio/Midi files
	sed -e "s:pa_unix_oss:lib:g" -e "s:pa_common:include:g" \
		-e "s:pm_linux:lib:g" -e "s:pm_common:include:g" \
		-i configure.in
	sed -e "s:lib/hydrogen:$(get_libdir)/hydrogen:g" -i plugins/wasp/Makefile.in

	epatch "${FILESDIR}/hydrogen-0.9.2-configure.in.patch"
	epatch "${FILESDIR}/hydrogen-0.9.3-gcc-4.1-tinyxml.h.patch"
	epatch "${FILESDIR}/${P}-flac113.patch"
	epatch "${FILESDIR}/${P}-automagic.patch"
	epatch "${FILESDIR}/${P}-desktop-noexec.patch"
	eautoreconf
}

src_compile() {
	export PORTAUDIOPATH="/usr"
	# PortMidi not yet in the repository
	# export PORTMIDIPATH="/usr"

	local myconf="$(use_enable jack jack-support) \
			$(use_enable portaudio) \
			$(use_enable alsa) \
			$(use_enable debug) \
			$(use_enable flac flac_support) \
			$(use_enable ladspa) \
			$(use_enable ladspa lrdf-support) \
			$(use_enable oss oss-support)"

	econf ${myconf} || die "Failed configuring hydrogen!"
	emake || die "Failed making hydrogen!"
}

src_install() {
	pushd data/i18n
	use doc && ./updateTranslations.sh
	rm *.ts updateTranslations.sh
	popd

	pushd data/doc
	use doc && ./updateManuals.sh
	rm *.docbook updateManuals.sh
	popd

	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	dosym /usr/share/hydrogen/data/doc /usr/share/doc/${PF}/html
	doman man/C/hydrogen.1

	for N in 16 24 32 48 64 ; do
		dodir /usr/share/icons/hicolor/${N}x${N}/apps
		dosym /usr/share/hydrogen/data/img/gray/icon${N}.png \
			 /usr/share/icons/hicolor/${N}x${N}/apps/hydrogen.png
	done
	dodir /usr/share/icons/hicolor/scalable/apps
	dosym /usr/share/hydrogen/data/img/gray/icon.svg \
		/usr/share/icons/hicolor/scalable/apps/hydrogen.svg
}
