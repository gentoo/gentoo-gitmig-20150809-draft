# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-0.59.9-r1.ebuild,v 1.2 2003/04/17 16:53:26 lostlogic Exp $

inherit kde-functions eutils

EV=1.16
DESCRIPTION="GTK Instant Messenger client"
SRC_URI="mirror://sourceforge/gaim/${P}.tar.bz2
	ssl? ( mirror://sourceforge/gaim-encryption/encrypt-${EV}.tar.gz )"
HOMEPAGE="http://gaim.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
IUSE="nas nls esd gnome arts perl ssl"

DEPEND="=sys-libs/db-1*
	esd? ( >=media-sound/esound-0.2.22-r2 )
	nls? ( sys-devel/gettext )
	nas? ( >=media-libs/nas-1.4.1-r1 )
	arts? ( >=kde-base/arts-0.9.5 )
	perl? ( >=dev-lang/perl-5.6.1 )
	( gnome? ( =gnome-base/gnome-panel-1.4* >=media-libs/gdk-pixbuf-0.16.0 ) : 
  	( =x11-libs/gtk+-1.2* =dev-libs/glib-1.2* ) )
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}/plugins
	use ssl && {
		unpack encrypt-${EV}.tar.gz
		epatch encrypt/patchfile.0.59.5
	}
}

src_compile() {
	local myconf
	use esd  || myconf="--disable-esd"
	use perl || myconf="${myconf} --disable-perl"
	use nas && myconf="${myconf} --enable-nas" || myconf="${myconf} --disable-nas"

	use arts && set-kdedir 3 || myconf="${myconf} --disable-artsc"
	use nls || myconf="${myconf} --disable-nls"

	# We always build a standalone version of gaim.
	# In this build, GNOME is always disabled.
	cp configure{,.old}		# fix for #13533
	sed -e 's:-I\\$(top_srcdir)::' configure.old > configure
	econf ${myconf} --disable-gnome || die
	emake || die

	# if gnome support is enabled (and gtk2 disabled), then build gaim_applet
	if [ "`use gnome`" ];
	then
		# save applet-less version and clean up...
		cp src/gaim ${S}/gaim || die "standalone version failed to build"
		make distclean || die

		econf ${myconf} --with-gnome=${GNOME_PATH} --enable-panel || die
		emake || die "applet failed to build"
	fi
}

src_install () {
	make DESTDIR=${D} install || die
	# if gnome enabled, make sure to install standalone version also
	if [ "`use gnome`" ]
	then
		dobin ${S}/gaim
	fi
	dodoc ABOUT-NLS AUTHORS HACKING INSTALL NEWS README TODO
}
