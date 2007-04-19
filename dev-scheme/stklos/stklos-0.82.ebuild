# Copyright 1999-2007 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/stklos/stklos-0.82.ebuild,v 1.1 2007/04/19 15:21:19 hkbst Exp $

DESCRIPTION="fast and light Scheme implementation"
HOMEPAGE="http://www.stklos.org"
SRC_URI="http://www.stklos.org/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
