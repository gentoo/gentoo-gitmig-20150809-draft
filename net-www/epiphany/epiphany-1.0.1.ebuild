# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/epiphany/epiphany-1.0.1.ebuild,v 1.3 2003/10/18 22:54:00 brad_mssw Exp $

inherit gnome2

DESCRIPTION="GNOME webbrowser based on the mozilla rendering engine"
HOMEPAGE="http://epiphany.mozdev.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha amd64"
IUSE="gnome"

RDEPEND=">=gnome-base/gconf-1.2
	>=x11-libs/gtk+-2
	>=dev-libs/libxml2-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/libbonoboui-2.2
	>=gnome-base/ORBit2-2
	>=gnome-base/gnome-vfs-2
	>=net-www/mozilla-1.4
	gnome? ( >=gnome-base/nautilus-2.2 )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	sys-devel/autoconf
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README TODO"

use gnome \
	&& G2CONF="${G2CONF} --enable-nautilus-view=yes" \
	|| G2CONF="${G2CONF} --enable-nautilus-view=no"

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
	cd ${S}

	# fixing --server related session_get_windows(session) problems
	# http://bugzilla.gnome.org/show_bug.cgi?id=124042
	epatch ${FILESDIR}/${P}-session_get_windows-session.patch
}
