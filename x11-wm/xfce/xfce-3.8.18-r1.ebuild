# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/xfce/xfce-3.8.18-r1.ebuild,v 1.4 2003/09/04 05:11:37 msterret Exp $

IUSE="arts gtk gnome nls"

S=${WORKDIR}/${P}

DESCRIPTION="XFce is a lightweight desktop environment for various UNIX systems."
SRC_URI="mirror://sourceforge/xfce/${P}.tar.gz"
HOMEPAGE="http://www.xfce.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	gnome? ( dev-libs/libxml2 )
	gtk? ( >=media-libs/gdk-pixbuf-0.11.0-r1 >=media-libs/imlib-1.9.10-r1 )
	arts? ( kde-base/arts )"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use gtk && myconf="--enable-imlib=no --enable-gdk-pixbuf=/usr"

	use gnome && myconf="${myconf} --enable-gdm --enable-libxml2"

	use nls || myconf="${myconf} --disable-nls"

	use arts && myconf="${myconf} --enable-arts"

	econf \
	    --enable-xft \
	    --enable-taskbar \
	    ${myconf} || die

	cd docs
	cp Makefile Makefile.orig
	sed "s:/usr/share/xfce:/usr/share/doc/${PF}:" Makefile.orig > Makefile
	cd ..

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodir /etc/skel/.xfce

	exeinto /etc/X11/Sessions
	doexe $FILESDIR/xfce

	dodoc ChangeLog* AUTHORS LICENSE README* TODO*
}
