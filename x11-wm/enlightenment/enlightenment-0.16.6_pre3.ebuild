# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.16.6_pre3.ebuild,v 1.1 2003/06/19 04:39:09 vapier Exp $

DESCRIPTION="Enlightenment Window Manager"
SRC_URI="mirror://sourceforge/enlightenment/${P/_/-}.tar.gz"
HOMEPAGE="http://www.enlightenment.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="nls esd gnome kde"

DEPEND=">=media-libs/fnlib-0.5
	esd? ( >=media-sound/esound-0.2.19 )
	=media-libs/freetype-1*
	>=gnome-base/libghttp-1.0.9-r1
	>=media-libs/imlib-1.9.8"
RDEPEND="nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}-${PV/_pre3/}

src_compile() {
	econf \
		`use_enable nls` \
		`use_enable esd sound` \
		--enable- \
		--enable-upgrade \
		--enable-hints-ewmh \
		`use_enable gnome hints-gnome` \
		`use_enable kde hints-kde` \
		--enable-fsstd \
		--enable-zoom \
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR=${D} || die

	dodoc AUTHORS ChangeLog FAQ INSTALL NEWS README
	docinto sample-scripts
	dodoc sample-scripts/*

	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/enlightenment
}
