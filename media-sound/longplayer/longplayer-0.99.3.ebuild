# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/longplayer/longplayer-0.99.3.ebuild,v 1.2 2004/04/01 12:03:59 dholm Exp $

inherit eutils kde

IUSE="berkdb"
MY_P=${P/longplayer/lplayer}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A MP3 jukebox especially for large collections, with rating support for single songs"
HOMEPAGE="http://lplayer.sourceforge.net"
SRC_URI="mirror://sourceforge/lplayer/${MY_P}_src.tgz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

RDEPEND="x11-libs/qt
	media-sound/xmms
	berkdb? ( =sys-libs/db-4.1* )"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7.8
	>=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch

	cd ${S}
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7
	sh admin/cvs.sh configure.in || die
	aclocal || die
	autoconf || die
}

src_compile() {
	addwrite "${QTDIR}/etc/settings"

	econf `use_enable berkdb berkeleydb` || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	einstall || dir "einstall failed"
	dodoc AUTHORS BUGS COPYING FAQ ChangeLog INSTALL NEWS README TODO
}
