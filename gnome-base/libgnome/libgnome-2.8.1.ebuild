# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnome/libgnome-2.8.1.ebuild,v 1.3 2005/03/25 01:42:02 halcy0n Exp $

inherit gnome2 eutils

DESCRIPTION="Essential Gnome Libraries"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.0.3
	>=gnome-base/gconf-2
	>=gnome-base/libbonobo-2
	>=gnome-base/gnome-vfs-2.5.3
	>=media-sound/esound-0.2.26
	>=media-libs/audiofile-0.2.3
	>=dev-libs/popt-1.5"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

G2CONF="${G2CONF} --disable-schemas-install "

DOCS="AUTHORS ChangeLog INSTALL NEWS README"

src_unpack() {

	unpack ${A}
	# patch to revert the behaviour of va_list, to stay
	# inline with agriffis' previous fix, see:
	# http://bugs.gentoo.org/show_bug.cgi?id=83153 and
	# http://bugzilla.gnome.org/show_bug.cgi?id=168110
	epatch ${FILESDIR}/${P}-va_list.patch

	# patch to fix gcc4 compile problem see: bug #85558
	epatch ${FILESDIR}/${PN}-gcc4.patch
}

