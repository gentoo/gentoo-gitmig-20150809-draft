# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/tilp2/tilp2-1.14.ebuild,v 1.1 2011/03/15 21:23:34 bicatali Exp $

EAPI="3"
inherit eutils

DESCRIPTION="Communication program for Texas Instruments calculators "
HOMEPAGE="http://lpg.ticalc.org/prj_tilp"
SRC_URI="mirror://sourceforge/tilp/tilp2-linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls threads xinerama"

RDEPEND="dev-libs/glib:2
	gnome-base/libglade:2.0
	x11-libs/gtk+:2
	>=sci-libs/libticalcs2-1.1.5
	>=sci-libs/libticables2-1.3.1
	>=sci-libs/libtifiles2-1.1.3
	>=sci-libs/libticonv-1.1.1
	nls? ( virtual/libintl )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	xinerama? ( x11-proto/xineramaproto )"

src_configure() {
	# kde seems to be kde3 only
	econf \
		--disable-rpath \
		--without-kde \
		$(use_enable nls) \
		$(use_enable threads threading) \
		$(use_with xinerama)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	rm -f "${ED}"usr/share/${PN}/{Manpage.txt,COPYING,RELEASE,AUTHORS,LICENSES}
	dodoc README AUTHORS ChangeLog RELEASE TODO
	make_desktop_entry tilp "TiLP TI Linker" \
		"${EPREFIX}"/usr/share/${PN}/pixmaps/icon.xpm
}
