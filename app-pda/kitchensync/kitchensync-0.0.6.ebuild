# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/kitchensync/kitchensync-0.0.6.ebuild,v 1.5 2005/01/14 23:14:44 danarmak Exp $

DESCRIPTION="KitchenSync is a synchronization framework for KDE3 and will be part of KDEPIM3.3"
HOMEPAGE="http://www.handhelds.org/~zecke/kitchensync.html"
SRC_URI="http://www.handhelds.org/~zecke/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=kde-base/kdepim-3.1 !kde-base/kitchensync !>=kde-base/kdepim-3.4.0_alpha1"

src_compile() {
	addwrite "${QTDIR}/etc/settings"
	./configure \
		--host=${CHOST} \
		--prefix=`kde-config --prefix` \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
