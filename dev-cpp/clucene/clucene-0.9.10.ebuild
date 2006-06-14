# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/clucene/clucene-0.9.10.ebuild,v 1.2 2006/06/14 17:47:50 nixnut Exp $

DESCRIPTION="High-performance, full-featured text search engine based off of lucene in C++"
HOMEPAGE="http://clucene.sourceforge.net/"

SRC_URI="mirror://sourceforge/clucene/${P}.tar.gz"
LICENSE="Apache-2.0 LGPL-2.1"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="static threads"
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
}


src_compile() {
	econf $(use_enable static) \
		$(use_enable threads multithreading) || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
