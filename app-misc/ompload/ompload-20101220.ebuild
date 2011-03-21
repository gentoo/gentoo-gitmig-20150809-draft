# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ompload/ompload-20101220.ebuild,v 1.4 2011/03/21 11:39:45 hwoarang Exp $

EAPI=3

DESCRIPTION="CLI script for uploading files to http://omploader.org/"
HOMEPAGE="http://ompldr.org/"
SRC_URI="mirror://gentoo/${P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc sparc ~x86 ~x86-fbsd"
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
