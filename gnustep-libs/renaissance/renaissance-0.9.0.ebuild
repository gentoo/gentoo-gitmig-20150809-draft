# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/renaissance/renaissance-0.9.0.ebuild,v 1.2 2008/09/17 20:57:35 maekke Exp $

inherit gnustep-2

DESCRIPTION="GNUstep Renaissance allows to describe user interfaces XML files"
HOMEPAGE="http://www.gnustep.it/Renaissance/index.html"
SRC_URI="http://www.gnustep.it/Renaissance/Download/${P/r/R}.tar.gz"

KEYWORDS="amd64 ~ppc x86"
LICENSE="LGPL-2.1"
SLOT="0"
S=${WORKDIR}/${P/r/R}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-0.8.1_pre20070522-docpath.patch
}
