# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-pilot-conduits/gnome-pilot-conduits-0.9.ebuild,v 1.8 2003/06/10 14:55:47 liquidx Exp $

IUSE="nls"


S=${WORKDIR}/${P}
DESCRIPTION="Gnome Pilot Conduits"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/unstable/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.eskil.org/gnome-pilot/"

DEPEND="<gnome-extra/gnome-pilot-2"

RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

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
