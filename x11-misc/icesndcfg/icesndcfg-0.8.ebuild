# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icesndcfg/icesndcfg-0.8.ebuild,v 1.3 2002/08/14 23:44:15 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="IceWM sound editor."
SRC_URI="http://www.selena.kherson.ua/xvadim/${P}.tar.bz2"
HOMEPAGE="http://www.selena.kherson.ua/xvadim"

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	esd? ( media-sound/esound )"

#RDEPEND="x11-wm/icewm
#	nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile () {

	local myconf

	use nls || myconf="--disable-nls"
	use esd \
		&& myconf="${myconf} --enable-esd" \
		|| myconf="${myconf} --disable-esd"

	econf \
		${myconf} || die
	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS COPYING TODO README
}
