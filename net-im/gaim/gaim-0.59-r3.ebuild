# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-0.59-r3.ebuild,v 1.2 2002/08/19 00:21:12 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK Instant Messenger client"
SRC_URI="mirror://sourceforge/gaim/${P}.tar.bz2"
HOMEPAGE="http://gaim.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="=sys-libs/db-1*
	esd? ( >=media-sound/esound-0.2.22-r2 )
	nls? ( sys-devel/gettext )
	nas? ( >=media-libs/nas-1.4.1-r1 )
	arts? ( >=kde-base/arts-0.9.5 )
	perl? ( >=sys-devel/perl-5.6.1 )
	gtk2? ( =x11-libs/gtk+-2.0* =dev-libs/glib-2.0* )
		  || ( =x11-libs/gtk+-1.2* =dev-libs/glib-1.2*
		     ( gnome? ( =gnome-base/gnome-panel-1.4* >=media-libs/gdk-pixbuf-0.16.0 ) ) )"

RDEPEND="${DEPEND}"

src_unpack() {

	unpack ${P}.tar.bz2
	
	# patch for korean encoding
	# It should be ok with other languages
	# the patch only works with nls 
	# PULLED -- got complaints it was hosing gtk2 non-korean users
	# use nls && patch -p0 < ${FILESDIR}/${P}-korean.patch

}

src_compile() {
	
	local myopts gnomeopts

	use esd  || myopts="--disable-esd"
	use nas  || myopts="${myopts} --disable-nas"
	use perl || myopts="${myopts} --disable-perl"

	use arts || myopts="${myopts} --disable-artsc"
	use arts && KDEDIR="${KDE3DIR}"

	use nls  || myopts="${myopts} --disable-nls"

	gnomeopts="${myopts}"

	if [ "`use gtk2`" ];
	then

		# GTK+ 2 support
		myopts="${myopts} --enable-gtk2"

	fi

	gnomeopts="${myopts}"

	# Gnome is disabled for GTK+ 2.0 build and first build of GTK 1.4 version
	myopts="${myopts} --disable-gnome"

	# always build standalone gaim program
	econf ${myopts} || die
	emake || die

	# if gnome support is enabled (and gtk2 disabled), then build gaim_applet
	if [ use gnome -a -z "`use gtk2`" ];
	then
		gnomeopts="${gnomeopts} --with-gnome=${GNOME_PATH} --enable-panel"

		# save appletless version and clean up
		cp src/gaim ${S}/gaim || die "standalone version failed to build"
		make distclean || die

		econf ${gnomeopts} || die
		emake || die
	fi
}

src_install () {

	make DESTDIR=${D} install || die

	# if gnome enabled, make sure to install standalone version also
	use gnome && dobin ${S}/gaim

	dodoc ABOUT-NLS AUTHORS HACKING INSTALL NEWS README TODO
}
