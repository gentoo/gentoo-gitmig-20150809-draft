# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/workrave/workrave-1.4.0.ebuild,v 1.3 2003/09/08 05:53:42 obz Exp $

DESCRIPTION="Helpful utility to attack Repetitive Strain Injury (RSI)"
HOMEPAGE="http://workrave.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

# This is the first workrave ebuild with gnome support,
# which should be considered experimental. The next
# step should be converting to the gnome2 eclass.
# <obz@gentoo.org>

LICENSE="GPL-2"
SLOT="0"
IUSE="nls xml2 gnome"
KEYWORDS="~x86"

RDEPEND=">=dev-libs/libsigc++-1.2
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=dev-cpp/gtkmm-2
	xml2? ( dev-libs/gdome2 )
	gnome? ( >=gnome-base/libgnomeui-2
			 >=dev-cpp/libgnomeuimm-1.3
			 >=gnome-base/gnome-panel-2.0.1
			 >=gnome-base/libbonobo-2
			 >=gnome-base/gconf-2 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {

	unpack ${A}
	cd ${S}
	# need to remove the configure specified CFLAGS
	sed -e "/CFLAGS/s/-O2//" -e "/CFLAGS/s/-g//" \
		< configure > configure.sed
	sed -e "/CXXFLAGS/s/-O2//" -e "/CFLAGS/s/-g//" \
		< configure.sed > configure

}

src_compile() {
	local myconf=""

	use gnome && myconf="${myconf} --enable-gnome --enable-gconf"
	use nls   || myconf="${myconf} --disable-nls"
	use xml2  && myconf="${myconf} --enable-xml"

	econf ${myconf} --disable-distribution || die

	# emake will bring nothing but trouble if you're using the `nls' USE
	# var
	make || die "Compilation failed"
}

src_install() {
	einstall || die

	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING NEWS README*
}
