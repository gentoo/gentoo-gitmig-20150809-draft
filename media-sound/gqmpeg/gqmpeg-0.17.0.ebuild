# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gqmpeg/gqmpeg-0.17.0.ebuild,v 1.6 2004/03/31 18:14:06 eradicator Exp $

IUSE="nls gnome"

DESCRIPTION="front end to various audio players, including mpg123"
HOMEPAGE="http://gqmpeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/gqmpeg/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/gdk-pixbuf-0.13.0"

RDEPEND="nls? ( sys-devel/gettext )"

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
