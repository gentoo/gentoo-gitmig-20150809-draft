# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ompload/ompload-20100909.ebuild,v 1.4 2011/02/13 19:21:51 armin76 Exp $

EAPI=2

DESCRIPTION="CLI script for uploading files to http://omploader.org/"
HOMEPAGE="http://ompldr.org/"
SRC_URI="mirror://gentoo/${P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/ruby-1.8
	net-misc/curl"

src_unpack() {
	install -D "${DISTDIR}"/${P} "${S}"/${PN} || die
}

src_install() {
	dobin ${PN} || die
}
