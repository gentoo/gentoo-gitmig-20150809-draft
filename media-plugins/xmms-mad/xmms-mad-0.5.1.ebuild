# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-mad/xmms-mad-0.5.1.ebuild,v 1.2 2002/12/15 12:08:24 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A XMMS plugin for MAD"
SRC_URI="mirror://sourceforge/xmms-mad/${P}.tar.gz"
HOMEPAGE="http://xmms-mad.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-sound/xmms 
	>=media-sound/mad-0.14.2b-r2"

src_install () {
	make DESTDIR=${D} install || die "Make failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
