# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/gml/gml-0.5.ebuild,v 1.1 2004/10/28 19:37:27 chrb Exp $

inherit eutils

DESCRIPTION="Google GMail Loader"
HOMEPAGE="http://www.marklyon.org/gmail"
SRC_URI="http://www.marklyon.org/gmail/gmlw.tar"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-python/pmw
	app-text/dos2unix"
S=${WORKDIR}/

src_unpack() {
	unpack ${A}
	dos2unix -o ${S}/gmlw.py
}

src_install() {
	dobin ${S}/gmlw.py || die
	dodoc ${S}/README ${S}/COPYING || die
}
