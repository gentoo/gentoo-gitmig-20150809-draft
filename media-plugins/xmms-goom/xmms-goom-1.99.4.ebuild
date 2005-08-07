# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-goom/xmms-goom-1.99.4.ebuild,v 1.15 2005/08/07 13:29:08 hansmi Exp $

inherit eutils

MY_P=${P/xmms-/}

DESCRIPTION="Trippy Visualisation for XMMS using SDL."
HOMEPAGE="http://ios.free.fr/?page=projet&quoi=1&lg=AN"
SRC_URI="http://ios.free.fr/goom/devel/${MY_P}-src.tgz
	mirror://debian/pool/main/x/xmms-goom/${PN}_${PV}-4.diff.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~mips ppc ~ppc64 sparc x86"
IUSE=""

DEPEND="media-sound/xmms
	media-libs/libsdl
	sys-apps/coreutils"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${WORKDIR}/${PN}_${PV}-4.diff
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
