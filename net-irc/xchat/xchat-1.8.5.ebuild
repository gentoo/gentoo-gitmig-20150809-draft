# Copyrigth 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-1.8.5.ebuild,v 1.4 2001/12/10 21:11:35 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="xchat irc client"
SRC_URI="http://www.xchat.org/files/source/1.8/${P}.tar.bz2"
HOMEPAGE="http://www.xchat.org/"

DEPEND=">=x11-libs/gtk+-1.2.10-r4
perl? ( sys-devel/perl )
python? ( >=dev-lang/python-2.1.1-r3 )
nls? ( >=sys-devel/gettext-0.10.38 )
gnome? ( >=gnome-base/gnome-core-1.4.0.4-r1 >=media-libs/gdk-pixbuf-0.11.0-r1 )
ssl? ( >=dev-libs/openssl-0.9.6a )"

RDEPEND=">=x11-libs/gtk+-1.2.10-r4
gnome? ( >=gnome-base/gnome-core-1.4.0.4-r1 >=media-libs/gdk-pixbuf-0.11.0-r1 )
ssl? ( >=dev-libs/openssl-0.9.6a )"

src_unpack() {
	cd ${WORKDIR}
	unpack ${A}
	cd ${S}
	cp configure configure.orig
	if [ "`use python`" ]
	then
		local mylibs=`/usr/bin/python-config`
		sed -e 's:PY_LIBS=".*":PY_LIBS="'"$mylibs"'":' configure.orig > configure
	fi
}

src_compile() {
	local myopts myflags

	#use gnome  	&& myopts="--enable-gnome --enable-panel"
	use gnome  	|| myopts="--enable-gtkfe --disable-gnome --disable-gdk-pixbuf --disable-zvt"
	use ssl    	&& myopts="$myopts --enable-openssl"
	use perl   	|| myopts="$myopts --disable-perl"
	use python 	&& myflags="`python-config`"
	use python 	|| myopts="$myopts --disable-python"
	use nls    	|| myopts="$myopts --disable-nls"
	use mmx		&& myopts="$myopts --enable-mmx"	 
	CFLAGS="$CFLAGS -I/usr/include/orbit-1.0"
	./configure --prefix=/usr --host=${CHOST} ${myopts} --enable-ipv6 || die
	patch -p1 < ${FILESDIR}/xc185fixbnc.diff
	emake || die
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc AUTHORS COPYING ChangeLog README
}
