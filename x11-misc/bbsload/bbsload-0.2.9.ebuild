# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbsload/bbsload-0.2.9.ebuild,v 1.3 2012/11/25 09:55:11 xarthisius Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="blackbox load monitor"
HOMEPAGE="http://sourceforge.net/projects/bbtools/"
SRC_URI="mirror://sourceforge/bbtools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="media-fonts/font-adobe-100dpi"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.2.8-as-needed.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README AUTHORS BUGS ChangeLog NEWS TODO data/README.bbsload
}
