# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-mad/xmms-mad-0.5.1-r1.ebuild,v 1.1 2003/07/17 10:34:02 raker Exp $

IUSE=""

DESCRIPTION="A XMMS plugin for MAD"
SRC_URI="mirror://sourceforge/xmms-mad/${P}.tar.gz"
HOMEPAGE="http://xmms-mad.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="media-sound/xmms 
	media-libs/libmad
	media-libs/libid3tag
	dev-util/pkgconfig"

S=${WORKDIR}/${P}

src_install () {
	make DESTDIR=${D} install || die "Make failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
