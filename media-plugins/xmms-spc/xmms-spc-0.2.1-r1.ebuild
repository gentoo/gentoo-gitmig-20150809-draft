# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-spc/xmms-spc-0.2.1-r1.ebuild,v 1.4 2004/10/31 10:49:20 eradicator Exp $

IUSE=""

inherit eutils gnuconfig libtool

MY_P=spcxmms-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="SPC Plugun for XMMS"
HOMEPAGE="http://www.self-core.org/~kaoru-k/"
SRC_URI="http://www.self-core.org/~kaoru-k/pub/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
#-sparc: 0.2.1-r1: audio does not play
#-amd64: 0.2.1-r1: audio plays incorrectly
KEYWORDS="x86 -amd64 -sparc"

RDEPEND="media-sound/xmms"
DEPEND="${RDEPEND}
	sys-devel/automake"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PF}.patch

	export WANT_AUTOMAKE=1.4
	export WANT_AUTOCONF=2.5

	aclocal || die
	automake || die
	autoconf || die
	elibtoolize
	gnuconfig_update
}

src_install() {
	make DESTDIR=${D} libdir=`xmms-config --input-plugin-dir` install || die
	dodoc AUTHORS COPYING NEWS README
}
