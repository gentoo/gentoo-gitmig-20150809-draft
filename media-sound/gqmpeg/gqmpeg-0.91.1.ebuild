# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gqmpeg/gqmpeg-0.91.1.ebuild,v 1.3 2006/10/05 08:38:31 flameeyes Exp $

IUSE="nls gnome"

DESCRIPTION="front end to various audio players, including mpg123"
HOMEPAGE="http://gqmpeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~ppc ~sparc ~amd64 ~ppc64"

RDEPEND=">=x11-libs/gtk+-2.4
	>=x11-libs/pango-1.2
	|| ( media-sound/mpg321 >=media-sound/mpg123-0.59p )
	media-sound/vorbis-tools
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc [A-KN-Z]*

	use gnome && ( \
		insinto /usr/share/gnome/apps/Multimedia
		doins ${FILESDIR}/gqmpeg.desktop
	)
}
