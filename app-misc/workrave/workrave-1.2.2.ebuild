# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/workrave/workrave-1.2.2.ebuild,v 1.2 2003/07/01 22:31:32 aliz Exp $

DESCRIPTION="Helpful utility to attack Repetitive Strain Injury (RSI)"
HOMEPAGE="http://workrave.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="nls xml2"
KEYWORDS="x86"

DEPEND="dev-lang/perl
	>=dev-libs/libsigc++-1.2
	>=dev-util/pkgconfig-0.9
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=x11-libs/gtkmm-2
	xml2? ( dev-libs/gdome2 )
	nls? ( sys-devel/gettext )"
#	gnome? ( >=gnome-base/libgnomeui-2 )

src_compile() {
	local myconf=""

	# Right now, options like --disable-gui-gtk and --enable-gui-text seem
	# to be broken. Aditionally, gnome support depends now on
	# gnome-extra/libgnomeuimm which is masked right now, so we're not
	# going to try and build it at the moment.
	use nls   || myconf="--disable-nls"
	#use gnome && myconf="${myconf} --enable-gnome --enable-gconf"
	use xml2  && myconf="${myconf} --enable-xml"

	econf ${myconf}
	
	# emake will bring nothing but trouble if you're using the `nls' USE
	# var
	make || die "Compilation failed"
}

src_install() {
	einstall

	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING NEWS README*
}
