# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/grip/grip-3.2.0.ebuild,v 1.8 2004/10/20 05:24:19 eradicator Exp $

IUSE="nls oggvorbis"

DESCRIPTION="GTK+ based Audio CD Player/Ripper."
HOMEPAGE="http://www.nostatic.org/grip"
SRC_URI="mirror://sourceforge/grip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~ppc sparc x86"

RDEPEND=">=x11-libs/gtk+-2.2
	x11-libs/vte
	=sys-libs/db-1*
	media-sound/lame
	media-sound/cdparanoia
	>=media-libs/id3lib-3.8.3
	>=gnome-base/libgnomeui-2.2.0
	>=gnome-base/orbit-2
	gnome-base/libghttp
	net-misc/curl
	oggvorbis? ( media-sound/vorbis-tools )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	econf --disable-dependency-tracking `use_enable nls` || die
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die

	insinto /usr/share/applnk/Multimedia
	doins ${D}/usr/share/applications/grip.desktop

	dodoc AUTHORS CREDITS ChangeLog README TODO
}
