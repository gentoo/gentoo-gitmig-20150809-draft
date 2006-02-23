# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/hydrogen/hydrogen-0.9.3.ebuild,v 1.1 2006/02/23 17:10:12 carlo Exp $

inherit eutils kde-functions

DESCRIPTION="Linux Drum Machine"
HOMEPAGE="http://hydrogen.sourceforge.net/"
SRC_URI="mirror://sourceforge/hydrogen/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~ppc64"
IUSE="alsa debug jack ladspa oss"

RDEPEND="dev-libs/libxml2
	media-libs/libsndfile
	media-libs/audiofile
	media-libs/flac
	media-libs/portaudio
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	ladspa? ( media-libs/liblrdf )"
DEPEND="app-text/docbook-sgml-utils
	${RDEPEND}"
need-qt 3

src_unpack() {
	unpack ${A}
	if use ppc; then
		cd ${S}/src
		epatch ${FILESDIR}/0.9.1-OSS.patch || die "patching failed"
	fi
	cd ${S}

	mv data/doc/man ${S}
	# broken or portability issue
	find . -iname Makefile.in -exec sed -i -e "s:update-menus::" {} \;
	# find PortAudio/Midi files
	sed -e "s:pa_unix_oss:lib:g" -e "s:pa_common:include:g" \
		-e "s:pm_linux:lib:g" -e "s:pm_common:include:g" \
		-i configure.in
	make -f Makefile.cvs
}

src_compile() {
	need-autoconf 2.5

	export PORTAUDIOPATH="${ROOT}usr"
	# PortMidi not yet in the repository
	# export PORTMIDIPATH="${ROOT}usr"

	local myconf="$(use_enable jack jack-support) \
			$(use_enable alsa) \
			$(use_enable debug) \
			$(use_enable ladspa) \
			$(use_enable ladspa lrdf-support) \
			$(use_enable oss oss-support)"

	econf ${myconf} || die "Failed configuring hydrogen!"
	emake || die "Failed making hydrogen!"
}

src_install() {
	pushd data/i18n
	./updateTranslations.sh
	rm *.ts updateTranslations.sh
	popd

	pushd data/doc
	./updateManuals.sh
	rm *.docbook updateManuals.sh
	popd

	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
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