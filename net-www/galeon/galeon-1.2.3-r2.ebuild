# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/net-www/galeon/galeon-1.2.3.ebuild,v 1.2 2002/05/27 17:27:39 drobbins Exp
S=${WORKDIR}/${P}
DESCRIPTION="A small web-browser for gnome that uses mozillas render engine"
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.gz
	 mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://galeon.sourceforge.net"

LICENSE="gpl-2"
KEYWORDS="*"
SLOT="0"

# dont merge mozilla-1.0, as it wont work with galeon, rather start
# with mozilla-1.0-r1
DEPEND="~net-www/mozilla-1.0
	>net-www/mozilla-1.0
	>=gnome-base/gnome-libs-1.4.1.4
	( >=gnome-base/libglade-0.17
	  <gnome-base/libglade-1.99.0 )
	( >=gnome-base/gnome-vfs-1.0
	  <gnome-base/gnome-vfs-1.9.0 )
	( >=gnome-base/gconf-1.0
	  <gnome-base/gconf-1.1.0 )
	>=gnome-base/oaf-0.6.7
	>=dev-libs/libxml-1.8.16
	>=media-libs/gdk-pixbuf-0.16.0-r1
	nls? ( sys-devel/gettext
	>=dev-util/intltool-0.11 )"

	# bonobo? ( >=gnome-base/bonobo-1.0.19-r1 )

src_unpack() {

	unpack ${A}
	cd ${S}
	# These patches break on this version of galeon.
	# Are they needed for gcc3/3.1 support?
	#patch -p1 < ${FILESDIR}/galeon-1.2.0-gcc3.patch || die
	#patch -p1 < ${FILESDIR}/galeon-1.2.1-gcc3.1.patch || die
}

src_compile() {

	local myconf

	use nls || myconf="${myconf} --disable-nls"
	# use bonobo && myconf="${myconf} --enable-gnome-file-selector"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--with-mozilla-libs=${MOZILLA_FIVE_HOME} \
		--with-mozilla-includes=${MOZILLA_FIVE_HOME}/include \
		--without-debug	--disable-werror \
		--disable-applet \
		--disable-install-schemas \
		--enable-nautilus-view=auto \
		${myconf} || die

	emake || die
}

src_install() {

	# galeon-config-tool was rewritten for 1.2.0 and causes sandbox
	# violations if gconfd is shut down...  The schemas seem to install
	# fine without it (at least it seems like it... *sigh*)
	#gconftool --shutdown

	make prefix=${D}/usr \
	     mandir=${D}/usr/share/man \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/lib \
	     install || die

	dodoc AUTHORS ChangeLog COPYING* FAQ NEWS README TODO THANKS
}

pkg_postinst() {

	galeon-config-tool --fix-gconf-permissions
	galeon-config-tool --pkg-install-schemas
	scrollkeeper-update
	
	if [ -z "`use gnome`" ]
	then
		einfo "Please remerge libglade with gnome support, or else galeon"
		einfo "will not be able to start up."
		einfo
		einfo 'To do this, type: '
		einfo 'USE="gnome" emerge libglade'
	fi
}

