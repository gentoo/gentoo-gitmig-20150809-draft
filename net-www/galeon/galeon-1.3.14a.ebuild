# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/galeon/galeon-1.3.14a.ebuild,v 1.9 2004/08/28 23:30:16 pvdabeel Exp $

inherit gnome2 debug libtool eutils

DESCRIPTION="A GNOME Web browser based on gecko (mozilla's rendering engine)"
HOMEPAGE="http://galeon.sourceforge.net"
SRC_URI="mirror://sourceforge/galeon/${P}.tar.bz2"
RESTRICT="nomirror"

IUSE=""
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~alpha sparc ~ia64 amd64"
SLOT="0"

S=${WORKDIR}/${P%%a}

# supports moz-1.4 to 1.6
RDEPEND="virtual/x11
	>=net-www/mozilla-1.4
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=dev-libs/libxml2-2.4
	>=gnome-base/gconf-2
	>=gnome-base/orbit-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2.1.1
	>=gnome-base/libgnomeui-2.0.5
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

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/galeon-gcc34-fix.gz
}

src_compile() {
	# even when we have the XML-Parser module there may be a version mismatch
	# this line will force the use of local intltool when compiling, avoiding mismatch
	# remove this when we have all users at the same version as upstream.
	intltoolize --force


	elibtoolize

	if [ `echo ${moz_ver} | grep 1.7rc` ]
	then
		moz_ver="trunk"
	fi

	local moz_ver="`pkg-config --modversion mozilla-xpcom | cut -d. -f1,2 2>/dev/null`"
	local myconf="--disable-werror"

	myconf="${myconf} --with-mozilla-snapshot=${moz_ver}"

	econf ${myconf} || die "configure failed"
	make || die "compile failed"

}

DOCS="AUTHORS COPYING COPYING.README ChangeLog FAQ INSTALL README README.ExtraPrefs THANKS TODO NEWS"
