# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-goom/xmms-goom-1.99.4.ebuild,v 1.9 2004/06/24 23:40:17 agriffis Exp $

inherit eutils

MY_P=${P/xmms-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Trippy Visualisation for XMMS using SDL."
HOMEPAGE="http://ios.free.fr/?page=projet&quoi=1&lg=AN"
SRC_URI="http://ios.free.fr/goom/devel/${MY_P}-src.tgz"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~mips "

IUSE=""

DEPEND="media-sound/xmms
	media-libs/libsdl
	sys-apps/coreutils"

src_unpack() {
	unpack ${A}
	cd ${S}/src

	epatch ${FILESDIR}/${PN}-gcc-3.3.patch
}

src_compile() {
	econf || die

	emake OPT="$CFLAGS" || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc INSTALL README AUTHORS NEWS KNOWNBUGS ChangeLog
}

pkg_postinst() {
	einfo "Press TAB for Fullscreen, +/- for resolution."
}
