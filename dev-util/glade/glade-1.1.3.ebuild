# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-1.1.3.ebuild,v 1.4 2003/02/27 11:37:14 spider Exp $

IUSE="nls gnome"

S=${WORKDIR}/${P}
DESCRIPTION="Glade is a GUI Builder. This release is for GTK+ 2 and GNOME 2."
SRC_URI="mirror://gnome/sources/glade/1.1/${P}.tar.bz2"
HOMEPAGE="http://glade.gnome.org/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc "

DEPEND="=x11-libs/gtk+-2*
	>=dev-libs/libxml2-2.4
	gnome? ( >=gnome-base/libgnomeui-2.0.0
		>=gnome-base/libgnomecanvas-2.0.0
		>=gnome-base/libbonoboui-2.0.0
		>=gnome-base/libgnomeprint-1.114.0 
		>=gnome-base/libgnomeprintui-1.114.0 )"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext
		>=dev-util/intltool-0.11 )
	>=app-text/scrollkeeper-0.2"

src_compile() {
	local myconf=""
	
	use gnome || myconf="--disable-gnome"
	use nls   || myconf="${myconf} --disable-nls"

	[ -n "$DEBUG" ] && myconf="$myconf --enable-debug"

	econf \
		--disable-gnome-db \
		${myconf}  || die "./configure failed"

	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"
	
	dodoc AUTHORS COPYING* FAQ NEWS README* TODO
}
