# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}
DESCRIPTION="A newsreader for GNOME."
SRC_URI="http://pan.rebelbase.com/download/releases/${PV}/SOURCE/${P}.tar.bz2"
HOMEPAGE="http://pan.rebelbase.com/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="virtual/x11 
	nls? ( sys-devel/gettext )
	>=gnome-base/gnome-libs-1.4.1.2-r1
	>=media-libs/gdk-pixbuf-0.11.0-r1
	>=dev-libs/libxml-1.8.11
	gtkhtml? ( >=gnome-extra/gtkhtml-0.14.0-r1 )"


src_compile() {
	local myconf=""

	if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-nls"
		mkdir intl
		touch intl/libgettext.h
	fi

	use gtkhtml && myconf="${myconf} --enable-html"

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --sysconfdir=/etc \
		    ${myconf} || die

	# Doesn't work with -j 4 (hallski)
	make || die
}

src_install() {
	make 	\
		prefix=${D}/usr	\
		sysconfdir=${D}/etc	\
	install

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

