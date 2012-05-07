# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qsynth/qsynth-0.3.6.ebuild,v 1.6 2012/05/07 10:39:04 yngwin Exp $

EAPI=4
LANGS="cs de es ru"

inherit qt4-r2 eutils flag-o-matic

DESCRIPTION="A Qt application to control FluidSynth"
HOMEPAGE="http://qsynth.sourceforge.net/"
SRC_URI="mirror://sourceforge/qsynth/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE="debug jack alsa pulseaudio"
KEYWORDS="amd64 ppc x86"

DEPEND=">=x11-libs/qt-core-4.2:4
	>=x11-libs/qt-gui-4.2:4
	>=media-sound/fluidsynth-1.0.7a[jack?,alsa?,pulseaudio?]
	x11-libs/libX11
	!pulseaudio? ( !jack? ( !alsa? ( >=media-sound/fluidsynth-1.0.7a[oss] ) ) )"
RDEPEND="${DEPEND}"

DOCS="AUTHORS ChangeLog README TODO TRANSLATORS"

src_prepare() {
	local lang use_langs
	for lang in ${LANGS} ; do
		if use linguas_${lang} ; then
			use_langs="${use_langs} src/translations/${PN}_${lang}.qm"
		fi
	done

	sed -e "s|\$(translations_targets)|${use_langs}|" -i Makefile.in \
		|| die "sed translations failed"

	sed -e 's/@make/@\$(MAKE)/' -i Makefile.in || die "sed Makefile failed"

	qt4-r2_src_prepare
}

src_configure() {
	# Stupidly, qsynth's configure does *not* use pkg-config to
	# discover the presence of Qt4, but uses fixed paths; as they
	# don't really work that well for our case, let's just use this
	# nasty hack and be done with it. *NOTE*: this hinders
	# cross-compile.
	append-flags -I/usr/include/qt4
	append-ldflags -L/usr/$(get_libdir)/qt4

	econf \
		$(use_enable debug)
	eqmake4 "${PN}.pro" -o "${PN}.mak"
}

src_compile() {
	lupdate "${PN}.pro" || die "lupdate failed"
	qt4-r2_src_compile
}

src_install () {
	qt4-r2_src_install

	# The desktop file is invalid, and we also change the command
	# depending on useflags
	rm -rf "${D}/usr/share/applications/qsynth.desktop"

	local cmd
	if use jack; then
		cmd="qsynth"
	elif use pulseaudio; then
		cmd="qsynth -a pulseaudio"
	elif use alsa; then
		cmd="qsynth -a alsa"
	else
		cmd="qsynth -a oss"
	fi

	make_desktop_entry "${cmd}" Qsynth qsynth
}
