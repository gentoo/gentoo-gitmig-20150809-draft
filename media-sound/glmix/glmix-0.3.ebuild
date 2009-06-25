# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/glmix/glmix-0.3.ebuild,v 1.3 2009/06/25 17:46:57 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A 3D widget for mixing up to eight JACK audio streams down to stereo"
HOMEPAGE="http://devel.tlrmx.org/audio"
SRC_URI="http://devel.tlrmx.org/audio/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

RDEPEND="media-sound/jack-audio-connection-kit
	 >=x11-libs/gtkglext-1
	 >=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	local libs="gtk+-2.0 gtkglext-1.0 jack pango"
	emake CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} $(pkg-config --cflags ${libs})" \
		LDFLAGS="${LDFLAGS} $(pkg-config --libs ${libs})" || die "emake failed."
}

src_install() {
	dobin ${PN}
	dodoc README TODO
	make_desktop_entry ${PN} "GL Mixer"
}
