# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-1.1.0.ebuild,v 1.1 2002/05/28 23:43:35 spider Exp $

S=${WORKDIR}/${P}
SLOT="0"
DESCRIPTION="Glade is a GUI Builder. This release is for GTK+ 2 and GNOME 2."
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/glade/${P}.tar.bz2"

HOMEPAGE="http://glade.gnome.org/"

LICENSE="GPL-2"

RDEPEND="=x11-libs/gtk+-2.0*
	=dev-libs/libxml2-2.4*
	gnome? ( >=gnome-base/libgnomeui-1.117.1
		>=gnome-base/libgnomecanvas-1.117.0
		>=gnome-base/libbonoboui-1.117.0
		>=gnome-extra/libgnomeprintui-1.114.0 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext
		>=dev-util/intltool-0.11 )
	>=app-text/scrollkeeper-0.2"

src_compile() {
	local myopts
	use gnome || myopts="--disable-gnome"
	use nls || myopts="${myopts} --disable-nls"

	if [ "$DEBUG" ]
	then	
		myopts="$myopts --enable-debug"
	fi

	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--disable-gnome-db \
		${myopts}  || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		install || die
	dodoc AUTHORS COPYING* FAQ NEWS README* TODO
}
