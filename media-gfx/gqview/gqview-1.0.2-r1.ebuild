# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gqview/gqview-1.0.2-r1.ebuild,v 1.4 2002/07/23 04:33:46 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GNOME image browser"
SRC_URI="mirror://sourceforge/gqview/${P}.tar.gz"
HOMEPAGE="http://gqview.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-libs/libpng
	>=media-libs/gdk-pixbuf-0.16.0-r4
	=x11-libs/gtk+-1.2*"
	
RDEPEND="nls? ( sys-devel/gettext )"


src_compile() {

	local myconf
	
	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install() {

	einstall GNOME_DATADIR=${D}/usr/share || die
	
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
