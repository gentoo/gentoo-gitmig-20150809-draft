# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cstream/cstream-2.7.6.ebuild,v 1.2 2009/03/17 06:26:42 mr_bones_ Exp $

EAPI="2"

inherit autotools

DESCRIPTION="cstream is a general-purpose stream-handling tool like UNIX dd"
HOMEPAGE="http://www.cons.org/cracauer/cstream.html"
SRC_URI="http://www.cons.org/cracauer/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
