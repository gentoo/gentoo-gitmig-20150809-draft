# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-spc/xmms-spc-0.2.1-r2.ebuild,v 1.1 2006/08/18 00:35:32 metalgod Exp $

IUSE=""

inherit eutils gnuconfig libtool autotools

MY_P=spcxmms-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="SPC Plugun for XMMS"
HOMEPAGE="http://www.self-core.org/~kaoru-k/"
SRC_URI="http://www.self-core.org/~kaoru-k/pub/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
#-sparc: 0.2.1-r1: audio does not play
KEYWORDS="x86 ~amd64 -sparc -ppc"

RDEPEND="media-sound/xmms"
DEPEND="${RDEPEND}
	sys-devel/automake"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-r1.patch
	epatch ${FILESDIR}/${P}-amd64.patch
	epatch ${FILESDIR}/${P}-autoconf.patch

	export WANT_AUTOMAKE=1.4
	export WANT_AUTOCONF=2.5

	eautoreconf
	elibtoolize
	gnuconfig_update
}

src_install() {
	make DESTDIR=${D} libdir=`xmms-config --input-plugin-dir` install || die
	dodoc AUTHORS NEWS README
}
