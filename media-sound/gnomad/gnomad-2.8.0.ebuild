# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomad/gnomad-2.8.0.ebuild,v 1.2 2005/08/13 12:34:32 axxo Exp $

IUSE=""

inherit flag-o-matic gnome2

ALLOWED_FLAGS=""
strip-flags

MY_PN="${PN}2"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A GNOME2 frontend for Creative Players (Zen, JukeBox, etc ...)"
HOMEPAGE="http://gnomad2.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-sparc: 2.4.4: Application crashes on startup (Gnome crash detection)
KEYWORDS="~amd64 ~ppc -sparc x86"

RDEPEND=">=dev-libs/glib-2.6.0
	>=gnome-base/libgnomeui-2
	>=media-libs/libnjb-2.2
	media-libs/libid3tag
	>=gnome-base/gconf-1.2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21"

src_compile() {
	replace-flags -O3 -O2
	gnome2_src_compile
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README TODO
}
