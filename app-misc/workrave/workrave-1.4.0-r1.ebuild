# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/workrave/workrave-1.4.0-r1.ebuild,v 1.4 2003/10/24 13:02:20 leonardop Exp $

IUSE="debug gnome nls xml2"
# Internal USE flags
IUSE="${IUSE} no-exercises no-experimental distribution"

DESCRIPTION="Helpful utility to attack Repetitive Strain Injury (RSI)"
HOMEPAGE="http://workrave.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

# This is the first workrave ebuild with gnome support,
# which should be considered experimental. The next
# step should be converting to the gnome2 eclass.
# <obz@gentoo.org>

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=dev-cpp/gtkmm-2
	>=dev-libs/libsigc++-1.2
	distribution? ( >=net-libs/gnet-2 )
	gnome? ( >=gnome-base/libgnomeui-2
		>=dev-cpp/libgnomeuimm-2
		>=gnome-base/gnome-panel-2.0.10
		>=gnome-base/libbonobo-2 )
	nls? ( sys-devel/gettext )
	xml2? ( dev-libs/gdome2 )
	!xml2? ( >=gnome-base/gconf-2 )"

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
	use gnome           || myconf="${myconf} --disable-gnome"
	use nls             || myconf="${myconf} --disable-nls"
	use no-exercises    || myconf="${myconf} --enable-exercises"
	use no-experimental && myconf="${myconf} --disable-experimental"
	use xml2            && myconf="${myconf} --enable-xml" || \
		myconf="${myconf} --enable-gconf"

	econf ${myconf} || die

	# emake will bring nothing but trouble if you're using the `nls' USE
	# var
	make || die "Compilation failed"
}

src_install() {
	einstall || die

	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING NEWS README
}

