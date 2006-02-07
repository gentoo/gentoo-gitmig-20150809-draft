# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-goom/xmms-goom-2004.0.ebuild,v 1.7 2006/02/07 21:10:14 agriffis Exp $

inherit eutils

MY_PN=${PN/xmms-/}
MY_PV=2k4-0

DESCRIPTION="Trippy Visualisation for XMMS using SDL."
HOMEPAGE="http://www.ios-software.com/index.php3?page=projet&quoi=1"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}-${MY_PV}-src.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~mips ppc ~ppc64 sparc x86"
IUSE=""

DEPEND="media-sound/xmms
	media-libs/libsdl"

S=${WORKDIR}/${MY_PN}${MY_PV}

src_compile() {
	econf || die "econf failed"
	emake OPT="$CFLAGS" || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README AUTHORS NEWS KNOWNBUGS ChangeLog
}

pkg_postinst() {
	einfo "Press TAB for Fullscreen, +/- for resolution."
}

