# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-goom/xmms-goom-1.99.4.ebuild,v 1.2 2003/07/12 18:40:46 aliz Exp $

DESCRIPTION="Trippy Vis for XMMS using SDL."
MY_P=${P/xmms-/}
S=${WORKDIR}/${MY_P}
SRC_URI="http://ios.free.fr/goom/devel/${MY_P}-src.tgz"
HOMEPAGE="http://ios.free.fr/?page=projet&quoi=1&lg=AN"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86"

DEPEND="media-sound/xmms
	media-libs/libsdl
	sys-apps/sh-utils"

src_compile() {
	econf

	emake OPT="$CFLAGS" || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc INSTALL README AUTHORS NEWS KNOWNBUGS ChangeLog
}


src_postinst() {
	einfo "Press TAB for Fullscreen, +/- for resolution."
}

