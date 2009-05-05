# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/denemo/denemo-0.8.2.ebuild,v 1.1 2009/05/05 20:48:44 ssuominen Exp $

EAPI=2
inherit autotools

DESCRIPTION="GTK+ graphical music notation editor."
HOMEPAGE="http://denemo.sourceforge.net"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="jack nls"

RDEPEND=">=x11-libs/gtk+-2:2
	>=dev-libs/libxml2-2.3.10
	gnome-base/librsvg
	>=media-libs/aubio-0.3.2
	>=media-libs/portaudio-19_pre
	>=dev-scheme/guile-1.8
	media-libs/alsa-lib
	jack? ( >=media-sound/jack-audio-connection-kit-0.102 )"
DEPEND="${RDEPEND}
	|| ( dev-util/yacc sys-devel/bison )
	sys-devel/flex
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	# Wrong directory, icons is for theme sets
	sed -e 's:icons:pixmaps:g' -i src/view.c \
		-i pixmaps/Makefile.am || die "sed failed"
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable jack)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README*
}
