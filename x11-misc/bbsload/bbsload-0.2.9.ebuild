# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbsload/bbsload-0.2.9.ebuild,v 1.1 2012/06/04 19:08:48 xmw Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="blackbox load monitor"
HOMEPAGE="http://sourceforge.net/projects/bbtools/"
SRC_URI="mirror://sourceforge/bbtools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.2.8-as-needed.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README AUTHORS BUGS ChangeLog NEWS TODO data/README.bbsload
}
