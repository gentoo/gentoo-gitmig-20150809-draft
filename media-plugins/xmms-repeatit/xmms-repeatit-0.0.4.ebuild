# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-repeatit/xmms-repeatit-0.0.4.ebuild,v 1.5 2004/10/19 06:09:12 eradicator Exp $

IUSE=""

inherit gnuconfig

MY_P=${P/xmms-repeatit/RepeatIt}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Adds 'song repeat', 'clip repeat' and 'intro seek' to xmms."
HOMEPAGE="http://www.varberg.se/~sea1477a/"
SRC_URI="http://dev.gentoo.org/~squinky86/files/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64 sparc"
DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_install() {
	make DESTDIR="${D}" libdir=$(xmms-config --general-plugin-dir) install || die "make install failed"
	dodoc AUTHORS
}
