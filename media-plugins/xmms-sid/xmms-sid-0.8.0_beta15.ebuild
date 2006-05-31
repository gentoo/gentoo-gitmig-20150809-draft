# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-sid/xmms-sid-0.8.0_beta15.ebuild,v 1.6 2006/05/31 18:59:17 tcort Exp $

inherit eutils autotools libtool

MY_PV=${PV/_beta/beta}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="C64 SID plugin for XMMS"
HOMEPAGE="http://www.tnsp.org/xmms-sid.php"
SRC_URI="http://tnsp.org/xs-files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ppc sparc x86"
IUSE=""

# This really NEEDs one of the libsidplays, but unfortunately we need to RDEPEND on both for
# GRP to work right.
RDEPEND="media-sound/xmms
	=media-libs/libsidplay-1*
	=media-libs/libsidplay-2*"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-seek-popup-fix.patch
	eautoreconf
	elibtoolize
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog README* NEWS TODO
}
