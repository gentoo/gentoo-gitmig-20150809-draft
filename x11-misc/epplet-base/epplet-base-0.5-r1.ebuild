# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/epplet-base/epplet-base-0.5-r1.ebuild,v 1.12 2003/10/25 13:23:26 vapier Exp $

DESCRIPTION="Base files for Enlightenment epplets and some epplets"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="virtual/x11
	>=media-libs/imlib-1.9.10
	>=x11-wm/enlightenment-0.16.5-r4
	media-sound/esound"

S=${WORKDIR}/Epplets-${PV}

src_compile() {
	export EBIN=/usr/bin
	export EROOT=/usr/share/enlightenment
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog
}
