# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-mist/gtk-engines-mist-0.10.ebuild,v 1.5 2004/01/19 23:38:08 gustavoz Exp $

inherit gtk-engines2

MY_P="${P/engines-mist/mist-engine}"

IUSE=""
DESCRIPTION="GTK+1 and GTK+2 Mist Theme Engine"
HOMEPAGE="http://primates.ximian.com/~dave/mist/"
SRC_URI="http://primates.ximian.com/~dave/mist/${MY_P}.tar.gz"
KEYWORDS="x86 ~ppc ~alpha sparc hppa"
LICENSE="GPL-2"
SLOT="2"

DEPEND="!x11-themes/gnome-themes"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	# patch that adds --[enable|disable]-gtk-[1|2] - liquidx@g.o (04 Oct 03)
	epatch ${FILESDIR}/${P}-autoconf.patch
	cd ${S}; aclocal; automake; autoconf
}

src_compile() {
	local myconf
	if [ -n "${HAS_GTK1}" ]; then
		myconf="${myconf} --enable-gtk-1"
	else
		myconf="${myconf} --disable-gtk-1"
	fi

	if [ -n "${HAS_GTK2}" ]; then
		myconf="${myconf} --enable-gtk-2"
	else
		myconf="${myconf} --disable-gtk-2"
	fi

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}
