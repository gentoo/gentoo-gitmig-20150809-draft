# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/workrave/workrave-1.0.0.ebuild,v 1.5 2003/07/01 22:31:32 aliz Exp $

DESCRIPTION="assists in the recovery and prevention of Repetitive Strain Injury (RSI)"
HOMEPAGE="http://workrave.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="nls xml2 gnome"
KEYWORDS="x86"

DEPEND="dev-lang/perl
	>=dev-libs/libsigc++-1.2
	>=dev-util/pkgconfig-0.9
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=x11-libs/gtkmm-2
	xml2? ( dev-libs/gdome2 )
	gnome? ( >=gnome-base/libgnomeui-2 )
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf=""

	use nls   || myconf="--disable-nls"
	use gnome && myconf="${myconf} --enable-gnome --enable-gconf"
	use xml2  && myconf="${myconf} --enable-xml"

	econf ${myconf}
		
	emake || die "Compilation failed"
}

src_install() {
	einstall
	dodoc ABOUT-NLS AUTHORS COPYING NEWS README
}
