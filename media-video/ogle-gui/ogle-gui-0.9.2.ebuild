# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ogle-gui/ogle-gui-0.9.2.ebuild,v 1.9 2005/04/01 21:20:49 hansmi Exp $

inherit libtool

IUSE="nls gtk2"

MY_P=${P/-/_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="GUI interface for the Ogle DVD player."
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"
SRC_URI="${HOMEPAGE}/dist/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ppc ~alpha amd64 ~ia64 ~sparc"
LICENSE="GPL-2"

RDEPEND="
	>=media-video/ogle-${PV}
	!gtk2? ( =x11-libs/gtk+-1.2*
		=gnome-base/libglade-0* )
	gtk2? ( =x11-libs/gtk+-2*
		=gnome-base/libglade-2* )
	dev-libs/libxml2
	nls? ( sys-devel/gettext )"

DEPEND="
	dev-util/pkgconfig
	sys-devel/bison
	${RDEPEND}"


src_compile() {

	elibtoolize

	# libxml2 hack
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml"

	local myconf
	# braindead configure does not treat --disable-gtk2 correctly
	use gtk2 && myconf="--enable-gtk2"

	econf \
		`use_enable nls` \
		${myconf} || die
	emake || die

}

src_install() {

	einstall || die
	dodoc ABOUT-NLS AUTHORS COPYING INSTALL NEWS README
}
