# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmodplug/libmodplug-0.7.ebuild,v 1.1 2004/11/10 18:56:54 chainsaw Exp $

inherit eutils

IUSE=""

DESCRIPTION="Library for playing MOD-like music files"
SRC_URI="mirror://sourceforge/modplug-xmms/${P}.tar.gz"
HOMEPAGE="http://modplug-xmms.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND=""

src_unpack() {
	unpack ${A}

	cd ${S}/src/libmodplug
	epatch ${FILESDIR}/${P}-amd64.patch
}

src_compile() {
	econf || die "could not configure"
	emake LDFLAGS="$LDFLAGS -L${D}/usr/lib/" || die "emake failed"
}

src_install () {
	einstall
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}
