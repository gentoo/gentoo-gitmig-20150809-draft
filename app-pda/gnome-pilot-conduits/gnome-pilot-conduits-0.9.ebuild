# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gnome-pilot-conduits/gnome-pilot-conduits-0.9.ebuild,v 1.6 2004/07/24 20:16:27 liquidx Exp $

DESCRIPTION="Gnome Pilot Conduits"
SRC_URI="mirror://gnome/sources/gnome-pilot-conduits/${PV:0:3}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/projects/gnome-pilot/"

RDEPEND="<app-pda/gnome-pilot-2"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE="nls"

src_unpack() {

	unpack ${A}

	# the new gnome-pilot works better, but redefines
	# PI_AF_SLP to PI_AF_PILOT for some reason.
	cd ${S}/mal-conduit/mal/client/unix
	cp malsync.c malsync.c.orig
	sed "s:PI_AF_SLP:PI_AF_PILOT:" \
		malsync.c.orig > malsync.c
}

src_compile() {

	local myconf

	myconf="--enable-pilotlinktest"
	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}
