# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libotr/libotr-3.0.0.ebuild,v 1.6 2007/08/22 13:29:24 gustavoz Exp $

inherit flag-o-matic eutils

DESCRIPTION="(OTR) Messaging allows you to have private conversations over instant messaging"
HOMEPAGE="http://www.cypherpunks.ca/otr/"
SRC_URI="http://www.cypherpunks.ca/otr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""

DEPEND="dev-libs/libgpg-error
	>=dev-libs/libgcrypt-1.2.0"

src_compile() {
	strip-flags
	replace-flags -O? -O2

	econf || die "econf failed"
	emake -j1 || die "Make failed"
}

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	dodoc COPYING ChangeLog README
}
