# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/gml/gml-0.5.ebuild,v 1.5 2007/02/12 23:12:12 peper Exp $

inherit eutils

DESCRIPTION="Google GMail Loader"
HOMEPAGE="http://www.marklyon.org/gmail"
SRC_URI="http://www.marklyon.org/gmail/gmlw.tar"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc x86"
IUSE=""
DEPEND="dev-python/pmw"
S="${WORKDIR}/"

src_install() {
	edos2unix gmlw.py
	dobin gmlw.py || die
	dodoc README COPYING || die
}
