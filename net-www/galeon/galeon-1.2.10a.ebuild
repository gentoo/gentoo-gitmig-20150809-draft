# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/galeon/galeon-1.2.10a.ebuild,v 1.1 2003/04/23 09:05:10 liquidx Exp $

IUSE="nls"

inherit eutils libtool gnome.org

REQ_MOZ_VER="1.3"

S="${WORKDIR}/${P%%a}"
DESCRIPTION="A GNOME Web browser based on gecko (mozilla's rendering engine)"
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.gz
	 mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://galeon.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"
SLOT="0"

RDEPEND="=net-www/mozilla-${REQ_MOZ_VER}*
	>=gnome-base/gnome-libs-1.4.1.4
	<=gnome-base/libglade-0.99.0
	=gnome-base/gnome-vfs-1.0*
	=gnome-base/gconf-1.0*
	>=gnome-base/oaf-0.6.10
	>=dev-libs/libxml-1.8.17
	>=media-libs/gdk-pixbuf-0.18.0
	nls? ( sys-devel/gettext
	>=dev-util/intltool-0.17 )"
	# bonobo? ( >=gnome-base/bonobo-1.0.19-r1 )

DEPEND="${RDEPEND}
	app-text/scrollkeeper"

pkg_setup() {

	if [ ! -f ${ROOT}/usr/lib/mozilla/components/libwidget_gtk.so ]
	then
		eerror
		eerror "It seems that your Mozilla was not compiled against gtk+-1.2,"
		eerror "but rather gtk+-2.0.  As Galeon does not support this setup yet,"
		eerror "you will have to remerge Mozilla with gtk+-1.2 support.  This"
		eerror "can be done by taking \"gtk2\" out of your USE flags:"
		eerror
		eerror " # USE="-gtk2" emerge mozilla "
		eerror
		die "Need Mozilla compiled with gtk+-1.2!!"
	fi
}

src_unpack() {

	unpack ${A}

	# Add UTF8 support to the google smart bookmarks.  Note that
	# it will probibly only work for a newly created bookmark ...
	# <azarah@gentoo.org> (26 Dec 2002)
	cd ${S}; epatch ${FILESDIR}/${PN}-1.2.7-google-UTF8.patch
}

src_compile() {

	elibtoolize

	local myconf=
	local moz_ver="`pkg-config --modversion mozilla-xpcom | cut -d. -f1,2 2>/dev/null`"

	[ -z "${moz_ver}" ] && moz_ver="${REQ_MOZ_VER}"

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
		--disable-werror \
		--disable-install-schemas \
		--enable-nautilus-view=no \
		--with-mozilla-snapshot=${moz_ver} \
		${myconf} || die

	emake || make || die
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
		einfo "Please make sure libglade was built with gnome support, or"
		einfo "else galeon will not be able to start up."
		einfo
		einfo 'To do this, type: '
		einfo 'USE="gnome" emerge libglade'
	fi
}

