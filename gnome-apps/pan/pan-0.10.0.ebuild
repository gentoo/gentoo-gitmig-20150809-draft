# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Erik Van Reeth <erik@vanreeth.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/pan/pan-0.10.0.ebuild,v 1.1 2001/09/08 15:13:07 agriffis Exp $


A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="A newsreader for GNOME."
SRC_URI="http://pan.rebelbase.com/download/${PV}/SOURCE/${A}"
HOMEPAGE="http://pan.rebelbase.com/"

DEPEND="virtual/x11 
        nls? ( sys-devel/gettext )
	>=gnome-base/gnome-libs-1.0.16
        gtkhtml? ( >=gnome-base/gtkhtml-0.8.3 )"

src_compile() {
        local myconf
	use nls     || myconf=--disable-nls
	use gtkhtml && myconf="$myconf --enable-html"
	./configure --prefix=/opt/gnome $myconf || die
	# Doesn't work with -j 4 (hallski)
	make || die
}

src_install () {
	make prefix=${D}/opt/gnome install
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
