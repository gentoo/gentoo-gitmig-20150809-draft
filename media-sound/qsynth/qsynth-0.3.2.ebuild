# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qsynth/qsynth-0.3.2.ebuild,v 1.4 2008/04/26 16:51:40 nixnut Exp $

EAPI=1

inherit qt4 eutils flag-o-matic

DESCRIPTION="A Qt application to control FluidSynth"
HOMEPAGE="http://qsynth.sourceforge.net/"
SRC_URI="mirror://sourceforge/qsynth/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE="debug jack alsa"
KEYWORDS="amd64 ppc ~sparc x86"

DEPEND="
	|| ( (
			x11-libs/qt-core:4
			x11-libs/qt-gui:4
		) >=x11-libs/qt-4.2:4 )
	>=media-sound/fluidsynth-1.0.7a"

pkg_setup() {
	if use jack; then
		if ! built_with_use media-sound/fluidsynth jack; then
			eerror "To use Qsynth with JACK, you need to build media-sound/fluidsynth"
			eerror "with the jack USE flag enabled."
			die "Missing jack USE flag on media-sound/fluidsynth"
		fi
		einfo "Enabling default JACK output."
	elif use alsa; then
		if ! built_with_use media-sound/fluidsynth alsa; then
			eerror "To use Qsynth with ALSA, you need to build media-sound/fluidsynth"
			eerror "with the alsa USE flag enabled."
			die "Missing alsa USE flag on media-sound/fluidsynth"
		fi
		einfo "Enabling non-default ALSA output."
	else
		if ! built_with_use media-sound/fluidsynth oss; then
			eerror "If you don't want to use either JACK or ALSA on Qsynth"
			eerror "you need to enable the oss USE flag on media-sound/fluidsynth"
			die "Missing oss USE flag on media-sound/fluidsynth"
		fi
		einfo "Enabling non-default OSS output."
	fi
}

src_compile() {
	# Stupidly, qsynth's configure does *not* use pkg-config to
	# discover the presence of Qt4, but uses fixed paths; as they
	# don't really work that well for our case, let's just use this
	# nasty hack and be done with it. *NOTE*: this hinders
	# cross-compile.
	append-flags -I/usr/include/qt4
	append-ldflags -L/usr/$(get_libdir)/qt4

	econf \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO

	# The desktop file is invalid, and we also change the command
	# depending on useflags
	rm -rf "${D}/usr/share/applications/qsynth.desktop"

	local cmd
	if use jack; then
		cmd="qsynth"
	elif use alsa; then
		cmd="qsynth -a alsa"
	else
		cmd="qsynth -a oss"
	fi

	make_desktop_entry "${cmd}" Qsynth qsynth
}
