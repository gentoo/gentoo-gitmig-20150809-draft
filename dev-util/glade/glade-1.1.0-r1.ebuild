# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-1.1.0-r1.ebuild,v 1.2 2002/07/23 11:22:17 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Glade is a GUI Builder. This release is for GTK+ 2 and GNOME 2."
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/glade/${P}.tar.bz2"
HOMEPAGE="http://glade.gnome.org/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-2*
	=dev-libs/libxml2-2.4*
	gnome? ( >=gnome-base/libgnomeui-1.117.1
		>=gnome-base/libgnomecanvas-1.117.0
		>=gnome-base/libbonoboui-1.117.0
		>=gnome-base/libgnomeprint-1.114.0 
		>=gnome-base/libgnomeprintui-1.114.0 )"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext
		>=dev-util/intltool-0.11 )
	>=app-text/scrollkeeper-0.2"

src_compile() {
	local myconf
	use gnome || myconf="--disable-gnome"
	use nls || myconf="${myconf} --disable-nls"

	if [ "$DEBUG" ]
	then	
		myconf="$myconf --enable-debug"
	fi

	econf \
		--disable-gnome-db \
		${myconf}  || die

	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING* FAQ NEWS README* TODO
}
