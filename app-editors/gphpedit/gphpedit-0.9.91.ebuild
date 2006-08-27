# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gphpedit/gphpedit-0.9.91.ebuild,v 1.1 2006/08/27 20:01:57 compnerd Exp $

inherit gnome2 eutils

DESCRIPTION="A Gnome2 PHP/HTML source editor"
HOMEPAGE="http://www.gphpedit.org/"
SRC_URI="http://www.gphpedit.org/download/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0
		 >=dev-libs/glib-2.0
		 >=gnome-base/libgnomeui-2.0
		 >=gnome-base/gnome-vfs-2.0
		  =gnome-extra/gtkhtml-2*"

DEPEND="${RDEPEND}
		sys-devel/gettext
		>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog README TODO"

src_unpack() {
	gnome2_src_unpack

	epatch ${FILESDIR}/${PN}-0.9.91-empty-apply-prefs.patch
}
