# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/denemo/denemo-0.7.6.ebuild,v 1.2 2007/08/16 19:02:58 gustavoz Exp $

DESCRIPTION="GTK+ graphical music notation editor."
HOMEPAGE="http://denemo.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc ~x86"
IUSE="alsa nls"

RDEPEND=">=x11-libs/gtk+-2
	dev-libs/libxml2
	gnome-base/librsvg
	alsa? ( >=media-libs/alsa-lib-0.9 )"
DEPEND="${RDEPEND}
	|| ( dev-util/yacc sys-devel/bison )
	sys-devel/flex
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# denemo.png installs to wrong directory.
	sed -e 's:icons:pixmaps:' -i src/view.c \
		-i pixmaps/Makefile.in
}

src_compile() {
	econf --enable-gtk2 --disable-xmltest --disable-alsatest \
		$(use_enable nls) $(use_enable alsa)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog DESIGN* GOALS NEWS README* TODO
}
