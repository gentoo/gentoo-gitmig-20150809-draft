# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomad/gnomad-2.8.12.ebuild,v 1.2 2007/06/26 02:14:21 mr_bones_ Exp $

inherit flag-o-matic gnome2

MY_PN="${PN}2"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A GNOME2 frontend for Creative Players (Zen, JukeBox, etc ...)"
HOMEPAGE="http://gnomad2.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

#-sparc: 2.4.4: Application crashes on startup (Gnome crash detection)
KEYWORDS="~amd64 ~ppc -sparc ~x86"

# Yes, these dependencies are not elegant. However, the upstream configure
# script offers no flexibility on this point. Sorry.
RDEPEND=">=dev-libs/glib-2.6.0
	>=x11-libs/gtk+-2.6
	>=media-libs/libnjb-2.2.4
	>=media-libs/libmtp-0.1.3
	media-libs/libid3tag"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
