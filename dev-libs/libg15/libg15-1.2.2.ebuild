# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libg15/libg15-1.2.2.ebuild,v 1.4 2007/08/25 17:33:21 beandog Exp $

DESCRIPTION="The libg15 library gives low-level access to the Logitech G15 keyboard"
HOMEPAGE="http://g15tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/g15tools/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~x86"
IUSE=""

DEPEND="dev-libs/libusb"
RDEPEND=${DEPEND}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS README ChangeLog
}
