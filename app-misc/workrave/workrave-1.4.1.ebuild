# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/workrave/workrave-1.4.1.ebuild,v 1.2 2004/01/06 20:11:13 weeve Exp $

IUSE="debug gnome nls xml2"
# Internal USE flags
IUSE="${IUSE} no-exercises no-experimental distribution"

DESCRIPTION="Helpful utility to attack Repetitive Strain Injury (RSI)"
HOMEPAGE="http://workrave.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=dev-cpp/gtkmm-2
	>=dev-libs/libsigc++-1.2
	distribution? ( >=net-libs/gnet-2 )
	gnome? ( >=gnome-base/libgnomeui-2
		>=dev-cpp/libgnomeuimm-2
		>=gnome-base/gnome-panel-2.0.10
		>=gnome-base/libbonobo-2
		>=gnome-base/gconf-2 )
	nls? ( sys-devel/gettext )
	xml2? ( dev-libs/gdome2 )
	!xml2? ( !gnome? ( >=gnome-base/gconf-2 ) )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"


src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gcc2_fixes.patch

	# need to remove the configure specified CFLAGS
	sed -e "/CFLAGS/s/-O2//" -e "/CFLAGS/s/-g//" \
		< configure > configure.sed
	sed -e "/CXXFLAGS/s/-O2//" -e "/CFLAGS/s/-g//" \
		< configure.sed > configure
}

src_compile() {
	local myconf=""

	use debug           && myconf="${myconf} --enable-debug"
	use distribution    || myconf="${myconf} --disable-distribution"
	use nls             || myconf="${myconf} --disable-nls"
	use no-exercises    || myconf="${myconf} --enable-exercises"
	use no-experimental && myconf="${myconf} --disable-experimental"
	use xml2            && myconf="${myconf} --enable-xml"

	if [ `use gnome` ]
	then
		myconf="${myconf} --enable-gconf"
	else
		myconf="${myconf} --disable-gnome"
	fi

	if [ ! `use gnome` ] && [ ! `use xml2` ]
	then
		myconf="${myconf} --enable-gconf"
	fi

	econf ${myconf} || die

	# emake will bring nothing but trouble if you're using the `nls' USE
	# var
	make || die "Compilation failed"
}

src_install() {
	einstall || die

	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING NEWS README
}

