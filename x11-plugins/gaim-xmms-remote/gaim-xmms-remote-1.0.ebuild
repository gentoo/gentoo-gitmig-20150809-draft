# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-xmms-remote/gaim-xmms-remote-1.0.ebuild,v 1.3 2004/04/05 15:27:56 rizzo Exp $

DESCRIPTION="Gaim XMMS Remote is a Gaim plugin that lets you control XMMS from within gaim."

HOMEPAGE="http://guifications.sourceforge.net/gaim-xmms-remote/"
SRC_URI="mirror://sourceforge/guifications/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-im/gaim-0.75
		media-sound/xmms"
#RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	local myconf
	myconf=`use_enable debug`
	myconf="${myconf} --with-gaim=/usr/include/gaim"
	econf ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README VERSION
}
