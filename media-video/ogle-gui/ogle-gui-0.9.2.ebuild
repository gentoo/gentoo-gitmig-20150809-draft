# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ogle-gui/ogle-gui-0.9.2.ebuild,v 1.1 2003/12/13 21:28:58 seemant Exp $

inherit libtool

IUSE="nls gtk2"

MY_P=${P/-/_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="GUI interface for the Ogle DVD player."
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"
SRC_URI="${HOMEPAGE}/dist/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"
LICENSE="GPL-2"

DEPEND=">=media-video/ogle-${PV}
	!gtk2? ( =x11-libs/gtk+-1.2*
		=gnome-base/libglade-0* )
	gtk2? ( =x11-libs/gtk+-2*
		=gnome-base/libglade-2* )
	dev-libs/libxml2
	sys-devel/bison"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {

	elibtoolize

	# libxml2 hack
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml"

	econf \
		`use_enable nls` \
		`use_enable gtk2` || die
	emake || die

}

src_install() {

	einstall || die
	dodoc ABOUT-NLS AUTHORS COPYING INSTALL NEWS README
}
