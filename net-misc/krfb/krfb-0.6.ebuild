# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/krfb/krfb-0.6.ebuild,v 1.3 2002/05/21 18:14:11 danarmak Exp $

inherit kde-base || die

need-kde 3
DESCRIPTION="KDE Desktop Sharing Application"
SRC_URI="http://www.tjansen.de/krfb/${P}.tar.bz2"
HOMEPAGE="http://www.tjansen.de/krfb/"

src_install() {

	mkdir -p ${D}/${KDE3DIR}/share/apps/krfb
	make DESTDIR=${D} install || die

}
