# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ayttm/ayttm-0.4.4.ebuild,v 1.2 2003/12/05 08:59:48 usata Exp $

IUSE="arts esd gnome nls"

S=${WORKDIR}/${P}
DESCRIPTION="Are you talking to me? - MSN, Jabber, IRC, ICQ, AIM, SMTP instant messenger"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://ayttm.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/audiofile
	arts? ( >=kde-base/arts-1.0.0 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.7 )
	esd? ( >=media-sound/esound-0.2.28 )"

src_compile() {

	econf \
		--enable-smtp \
		--enable-xft \
		`use_enable arts` \
		`use_enable esd` \
		`use_enable gnome` \
		`use_enable nls` || die
	emake || die

}

src_install () {

	einstall || die
	dodoc AUTHORS NEWS README TODO COPYING ChangeLog

}
