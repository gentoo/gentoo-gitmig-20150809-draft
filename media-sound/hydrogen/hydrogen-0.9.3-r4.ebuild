# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/hydrogen/hydrogen-0.9.3-r4.ebuild,v 1.4 2009/06/29 17:53:49 aballier Exp $

EAPI=2

inherit eutils kde-functions autotools multilib

DESCRIPTION="Linux Drum Machine"
HOMEPAGE="http://www.hydrogen-music.org/"
SRC_URI="mirror://sourceforge/hydrogen/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa debug doc +flac jack ladspa oss"

RDEPEND="dev-libs/libxml2
	media-libs/libsndfile
	media-libs/audiofile
	flac? ( media-libs/flac[cxx] )
	alsa? ( media-libs/alsa-lib[midi] )
	jack? ( media-sound/jack-audio-connection-kit )
	ladspa? ( media-libs/liblrdf )"
DEPEND="${RDEPEND}
	doc? ( app-text/docbook-sgml-utils )
	dev-util/pkgconfig"

need-qt 3

src_prepare() {
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
	epatch "${FILESDIR}/${P}-gcc43.patch"
	epatch "${FILESDIR}/${P}-gcc43noalsa.patch"
	epatch "${FILESDIR}/${P}-gcc44.patch"
	eautoreconf
}

src_configure() {
	export PORTAUDIOPATH="/usr"
	# PortMidi not yet in the repository
	# export PORTMIDIPATH="/usr"

	# Disable portaudio v18 support wrt #222841
	local myconf="$(use_enable jack jack-support) \
			--disable-portaudio \
			$(use_enable alsa) \
			$(use_enable debug) \
			$(use_enable flac flac_support) \
			$(use_enable ladspa) \
			$(use_enable ladspa lrdf-support) \
			$(use_enable oss oss-support)"

	econf ${myconf} || die "Failed configuring hydrogen!"
}

src_compile() {
	emake -j1 || die
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
