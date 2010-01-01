# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/md5deep/md5deep-3.4.ebuild,v 1.5 2010/01/01 19:59:46 fauli Exp $

DESCRIPTION="Expanded md5sum program with recursive and comparison options"
HOMEPAGE="http://md5deep.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="public-domain GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
