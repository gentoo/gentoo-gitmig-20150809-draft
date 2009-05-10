# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qsynth/qsynth-0.3.4.ebuild,v 1.1 2009/05/10 19:01:23 aballier Exp $

EAPI=2

inherit qt4 eutils flag-o-matic

DESCRIPTION="A Qt application to control FluidSynth"
HOMEPAGE="http://qsynth.sourceforge.net/"
SRC_URI="mirror://sourceforge/qsynth/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE="debug jack alsa pulseaudio"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="
	|| ( (
			x11-libs/qt-core:4
			x11-libs/qt-gui:4
		) =x11-libs/qt-4.3*:4 )
	>=media-sound/fluidsynth-1.0.7a[jack?,alsa?,pulseaudio?]
	!pulseaudio? ( !jack? ( !alsa? ( >=media-sound/fluidsynth-1.0.7a[oss] ) ) )"
RDEPEND="${DEPEND}"

src_configure() {
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
	eqmake4 "${PN}.pro" -o "${PN}.mak"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO

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
