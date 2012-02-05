# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qsynth/qsynth-0.3.2.ebuild,v 1.8 2012/02/05 17:38:35 armin76 Exp $

EAPI=2
inherit eutils flag-o-matic qt4

DESCRIPTION="A Qt application to control FluidSynth"
HOMEPAGE="http://qsynth.sourceforge.net/"
SRC_URI="mirror://sourceforge/qsynth/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="alsa debug jack"

RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	>=media-sound/fluidsynth-1.0.7a[alsa?,jack?]"
DEPEND="${RDEPEND}"

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
