# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ayttm/ayttm-0.4.2.ebuild,v 1.2 2003/10/22 19:22:42 usata Exp $

IUSE="arts esd gnome nls"

S=${WORKDIR}/${P}
DESCRIPTION="Are you talking to me? - MSN, Jabber, IRC, ICQ, AIM, SMTP instant messenger"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://ayttm.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/audiofile
	arts? ( >=kde-base/arts-1.0.0 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.7 )
	esd? ( >=media-sound/esound-0.2.28 )"

src_compile() {

	local myconf="--enable-smtp --enable-xft"

	use arts \
		&& myconf="--enable-arts" \
		|| myconf="--disable-arts"

	use esd \
		&& myconf="${myconf} --enable-esd" \
		|| myconf="${myconf} --disable-esd"

	use gnome \
		&& myconf="${myconf} --with-gnome" \
		|| myconf="${myconf} --without-gnome"

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	econf ${myconf} || die
	emake || die

}

src_install () {

	einstall || die
	dodoc AUTHORS NEWS README TODO COPYING ChangeLog

}
