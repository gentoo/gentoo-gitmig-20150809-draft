# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-infopipe/xmms-infopipe-1.3.ebuild,v 1.14 2004/09/15 19:25:57 eradicator Exp $

IUSE=""

DESCRIPTION="Publish information about currently playing song in xmms to a temp file"
SRC_URI="http://www.beastwithin.org/users/wwwwolf/code/xmms/${P}.tar.gz"
HOMEPAGE="http://www.beastwithin.org/users/wwwwolf/code/xmms/infopipe.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~alpha sparc amd64 ppc hppa"

DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${A}

	# Fix bad configure which breaks newer portage.
	cd ${S}
	mv configure configure.old
	cat - configure.old > configure << EOF
#!/bin/sh
EOF

	chmod 755 configure
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
