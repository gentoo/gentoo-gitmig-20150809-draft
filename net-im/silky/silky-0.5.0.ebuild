# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silky/silky-0.5.0.ebuild,v 1.2 2004/03/19 08:17:41 dholm Exp $

IUSE="debug"

DESCRIPTION="Simple and easy to use GTK+ based os-independent SILC client."
HOMEPAGE="http://silky.sourceforge.net"
SRC_URI="mirror://sourceforge/silky/silky-${PV}.tar.gz"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

SLOT="0"

# Silky currently does not work with silc-toolkit newer than 0.9.11. This bug
# is to be addressed in next release of Silky.
DEPEND="sys-libs/glibc
	sys-libs/zlib
	x11-base/xfree
	>=gnome-base/libglade-2
	>=x11-libs/gtk+-2.2
	x11-libs/pango
	dev-libs/atk
	>=dev-libs/glib-2.2
	dev-libs/libxml2
	app-misc/mime-types
	=net-im/silc-toolkit-0.9.11"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
}

src_compile() {
	local myconf

	myconf="${myconf} --with-silc-includes=/usr/include/silc-toolkit "
	myconf="${myconf} --with-silc-libs=/usr/lib "

	if [ "${DEBUG}" ]
	then
		einfo "debugging"
		myconf="${myconf} --enable-debug"
	fi

	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install
}
