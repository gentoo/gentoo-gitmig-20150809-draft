# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-goom/xmms-goom-1.10.0.ebuild,v 1.3 2003/07/12 18:40:45 aliz Exp $

MY_P=${P/xmms-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Trippy Vis for XMMS using SDL."
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/goom/${MY_P}.tgz"
HOMEPAGE="http://ios.free.fr/?page=projet&quoi=1&lg=AN"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86"

DEPEND="media-sound/xmms
	media-libs/libsdl
	sys-apps/sh-utils"

src_compile() {

	# special script for Athlon/Duron users
	if [ -n "`uname -p | grep Duron` || `uname -p | grep Athlon`" ]
	then
		einfo "Athlon/Duron prep"
		./athlon.sh
	fi

	econf
	# patch out the version mismatch junk
	patch libtool < ${FILESDIR}/${P}-libtool.patch || die
	emake OPT="$CFLAGS" || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc INSTALL README AUTHORS NEWS KNOWNBUGS ChangeLog
}


src_postinst() {
	einfo "Press TAB for Fullscreen, +/- for resolution."
}
