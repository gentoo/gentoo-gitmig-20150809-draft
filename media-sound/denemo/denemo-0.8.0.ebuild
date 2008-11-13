# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/denemo/denemo-0.8.0.ebuild,v 1.1 2008/11/13 22:09:53 loki_val Exp $

inherit base autotools

DESCRIPTION="GTK+ graphical music notation editor."
HOMEPAGE="http://denemo.sourceforge.net"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="alsa nls"

RDEPEND=">=x11-libs/gtk+-2
	dev-libs/libxml2
	gnome-base/librsvg
	media-libs/aubio
	=media-libs/portaudio-19*
	alsa? ( >=media-libs/alsa-lib-0.9 )"
DEPEND="${RDEPEND}
	|| ( dev-util/yacc sys-devel/bison )
	sys-devel/flex
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

PATCHES=( "${FILESDIR}/${P}-DESTDIR.patch" )

src_unpack() {
	base_src_unpack
	cd "${S}"
	# denemo.png installs to wrong directory.
	sed -e 's:icons:pixmaps:' -i src/view.c \
		-i pixmaps/Makefile.am
	eautoreconf
}

src_compile() {
	econf --enable-gtk2 --disable-xmltest --disable-alsatest \
		$(use_enable nls) $(use_enable alsa)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README*
}
