# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/galeon/galeon-1.3.17.ebuild,v 1.7 2004/10/22 01:46:19 spider Exp $

inherit gnome2 debug libtool eutils

DESCRIPTION="A GNOME Web browser based on gecko (mozilla's rendering engine)"
HOMEPAGE="http://galeon.sourceforge.net"
SRC_URI="mirror://sourceforge/galeon/${P}.tar.bz2"

LICENSE="GPL-2"
IUSE=""
KEYWORDS="x86 ppc alpha sparc amd64 ia64"
SLOT="0"

S=${WORKDIR}/${P%%a}

RDEPEND="virtual/x11
	>=net-www/mozilla-1.7.2-r1
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.4.0
	>=dev-libs/libxml2-2.6.6
	>=gnome-base/gconf-2.3.2
	>=gnome-base/orbit-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2.1.1
	>=gnome-base/libgnomeui-2.5.2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libglade-2.3.1
	app-text/scrollkeeper"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.30
	>=sys-devel/gettext-0.11"

pkg_setup () {
	if [ ! -f ${ROOT}/usr/lib/mozilla/components/libwidget_gtk2.so ]
	then
		eerror "you need mozilla-1.4+ compiled against gtk+-2"
		eerror "export USE=\"gtk2\" ;emerge mozilla -p "
		die "Need Mozilla compiled with gtk+-2.0!!"
	fi
}

src_compile() {
	elibtoolize

	local moz_ver="`pkg-config --modversion mozilla-xpcom | cut -d. -f1,2 2>/dev/null`"
	local myconf="--disable-werror"

	myconf="${myconf} --with-mozilla-snapshot=${moz_ver}"

	econf ${myconf} || die "configure failed"
	make || die "compile failed"

}

DOCS="AUTHORS COPYING COPYING.README ChangeLog FAQ INSTALL README README.ExtraPrefs THANKS TODO NEWS"
