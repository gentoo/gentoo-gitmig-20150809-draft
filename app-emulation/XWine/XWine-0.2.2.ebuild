# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/XWine/XWine-0.2.2.ebuild,v 1.4 2002/11/30 02:49:47 vapier Exp $

DESCRIPTION="GTK frontend for Wine"
HOMEPAGE="http://darken.tuxfamily.org/pages/xwine_en.html"
SRC_URI="http://darken.tuxfamily.org/projets/${P}_en.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64"
IUSE="nls gnome"

DEPEND=">=x11-libs/gtk+-1.2.10-r8
	>=net-www/mozilla-1.0-r2
	>=app-emulation/wine-20020710-r1
	sys-devel/bison
	gnome? ( >=gnome-base/gnome-libs-1.4.2 
		>=gnome-base/ORBit-0.5.17 )
	nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}
	>=app-emulation/winesetuptk-0.6.0b-r2"

S="${WORKDIR}/${P}_en"

src_compile() {
	local myconf

	use gnome && myconf="--with-gnome" \
		|| myconf="--without-gnome"

	use nls && myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	econf ${myconf}

	make || die
}

src_install() {
	einstall

	# Don't need to install docs twice
	rm -rf ${D}/usr/share/doc/xwine

	dodoc doc/Manual* FAQ* BUGS COPYING AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	einfo "${PN} requires a setup Wine to start....It is recommended"
	einfo "that you run winesetuptk prior to running ${PN} to setup"
	einfo "a base Wine install"
}	
