# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sawfish/sawfish-20020419.ebuild,v 1.1 2002/05/22 22:45:18 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/sawfish-2002-04-19
DESCRIPTION="Extensible window manager using a Lisp-based scripting language"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/sawfish/sawfish-2002-04-19.tar.bz2"
HOMEPAGE="http://sawmill.sourceforge.net/"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=x11-libs/rep-gtk-20020419
	>=dev-libs/librep-20020419
	>=media-libs/imlib-1.9.10-r1
	esd? ( >=media-sound/esound-0.2.22 )
	readline? ( >=sys-libs/readline-4.1 )
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	## Gdk-pixbuf in gnome2. I can't find it.
	myconf=" --without-gdk-pixbuf "
	myconf="${myconf} --with-gnome-prefix=/usr --disable-gnome-widgets --enable-capplet --enable-themer"
		
		if [ "`use esd`" ] ; then
			myconf="${myconf} --with-esd"
		else
			myconf="${myconf} --without-esd"
		fi

		if [ "`use readline`" ] ; then
			myconf="${myconf} --with-readline"
		else
			myconf="${myconf} --without-readline"
		fi
		
		if [ -z "`use nls`" ] ; then
			myconf="${myconf} --disable-linguas"
		fi

		./configure --host=${CHOST} \
			--prefix=/usr  \
			--infodir=/usr/share/info \
			--libexecdir=/usr/lib \
			--with-audiofile ${myconf} || die

			#pmake doesn't work, stick with make
			# old comment. try again.
			make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING ChangeLog DOC FAQ NEWS README THANKS TODO
	
	# Add to Gnome CC's Window Manager list
	insinto /usr/share/gnome/wm-properties
	doins ${FILESDIR}/Sawfish.desktop

}
