# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-smooth/gtk-engines-smooth-0.5.4.ebuild,v 1.1 2003/10/14 20:30:00 liquidx Exp $

inherit gtk-engines2

MY_P="gtk-smooth-engine-${PV}"

IUSE=""
DESCRIPTION="GTK+1 and GTK+2 Smooth Theme Engine"
HOMEPAGE="http://sourceforge.net/projects/smooth-engine/"
SRC_URI="mirror://sourceforge/smooth-engine/${MY_P}.tar.gz"
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="2"

S=${WORKDIR}/${MY_P}

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

