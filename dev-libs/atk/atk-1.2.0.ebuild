# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/atk/atk-1.2.0.ebuild,v 1.8 2003/03/04 21:29:18 weeve Exp $

inherit libtool gnome2

IUSE="doc"
S=${WORKDIR}/${P}
DESCRIPTION="Gnome Accessibility Toolkit"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc alpha sparc"

RDEPEND=">=dev-libs/glib-2.0.6-r1"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.9-r2 )
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	elibtoolize
	local myconf
	use doc \
		&& myconf="${myconf} --enable-gtk-doc" \
		|| myconf="${myconf} --disable-gtk-doc"

	if [ -n "$DEBUGBUILD" ]; then
		myconf="${myconf}  --enable-debug"
	fi
				
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS 
}
