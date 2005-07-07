# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-smooth/gtk-engines-smooth-0.6.0.1.ebuild,v 1.3 2005/07/07 03:11:40 agriffis Exp $

inherit gtk-engines2

MY_P="gtk-smooth-engine-${PV}"

IUSE="gtk"
DESCRIPTION="GTK+1 and GTK+2 Smooth Theme Engine"
HOMEPAGE="http://sourceforge.net/projects/smooth-engine/"
SRC_URI="mirror://sourceforge/smooth-engine/${MY_P}.tar.gz"
KEYWORDS="~x86 ~alpha ~ppc ~amd64 sparc"
LICENSE="GPL-2"
SLOT="2"

S=${WORKDIR}/${MY_P}

DEPEND="${DEPEND}
	!x11-themes/gnome-themes
	gtk? ( media-libs/gdk-pixbuf )"

src_compile() {
	local myconf

	[ -n "${HAS_GTK1}" ] \
		&& myconf="${myconf} --enable-gtk-1" \
		|| myconf="${myconf} --disable-gtk-1"

	[ -n "${HAS_GTK2}" ] \
		&& myconf="${myconf} --enable-gtk-2" \
		|| myconf="${myconf} --disable-gtk-2"

	gtk-engines2_src_compile ${myconf}
}

