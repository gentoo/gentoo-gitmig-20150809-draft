# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openhbci/openhbci-0.9.17-r1.ebuild,v 1.1 2005/03/08 00:33:57 jnc Exp $

inherit eutils

DESCRIPTION="Implementation of the HBCI protocol used by some banks"
HOMEPAGE="http://openhbci.sourceforge.net/"
SRC_URI="mirror://sourceforge/openhbci/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~alpha ~ppc sparc ~amd64"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.6"

src_compile() {
	./configure \
	--prefix=/usr \
	--infodir=/usr/share/info \
	--mandir=/usr/share/man || die "./configure failed"

	emake || die "parallel make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS README TODO
	dosym libopenhbci /usr/$(get_libdir)/libopenhbci.so  # HACK: closes #79736
}
