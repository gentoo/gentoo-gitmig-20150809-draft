# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Paul Fleischer <proguy@proguy.dk>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/epplet-base/epplet-base-0.5.ebuild,v 1.3 2002/05/27 17:27:40 drobbins Exp $

S="${WORKDIR}/Epplets-${PV}"

DESCRIPTION="Base files for Enlightenment epplets and some epplets"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"

HOMEPAGE="http://sourceforge.net/projects/enlightenment"

DEPEND=">=x11-base/xfree-4.2.0
	>=media-libs/imlib-1.9.10
	>=x11-wm/enlightenment-0.16.5-r4"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog
}
