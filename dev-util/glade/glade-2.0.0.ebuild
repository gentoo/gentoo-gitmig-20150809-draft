# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-2.0.0.ebuild,v 1.1 2003/04/12 18:06:03 foser Exp $

# FIXME : we could probably enable gnomedb support
inherit gnome.org

IUSE="gnome"

S=${WORKDIR}/${P}
DESCRIPTION="Glade is a GUI Builder. This release is for GTK+ 2 and GNOME 2."
HOMEPAGE="http://glade.gnome.org/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="=x11-libs/gtk+-2*
	>=dev-libs/libxml2-2.4.1
	gnome? ( >=gnome-base/libgnomeui-2.0.0
		>=gnome-base/libgnomecanvas-2.0.0
		>=gnome-base/libbonoboui-2.0.0 )"

RDEPEND="${DEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.11
	>=app-text/scrollkeeper-0.2"

src_compile() {
	local myconf=""
	
	use gnome || myconf="--disable-gnome"

	econf \
		--disable-gnome-db \
		${myconf}  || die "./configure failed"

	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"
	
	dodoc AUTHORS COPYING* FAQ NEWS README* TODO
}
