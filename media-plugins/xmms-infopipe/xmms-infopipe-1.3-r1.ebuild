# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-infopipe/xmms-infopipe-1.3-r1.ebuild,v 1.1 2005/10/31 03:09:03 metalgod Exp $

inherit eutils

IUSE=""

DESCRIPTION="Publish information about currently playing song in xmms to a temp file"
SRC_URI="http://www.beastwithin.org/users/wwwwolf/code/xmms/${P}.tar.gz"
HOMEPAGE="http://www.beastwithin.org/users/wwwwolf/code/xmms/infopipe.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

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

	epatch ${FILESDIR}/${PN}-tweaks.patch
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README
}
