# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/xar/xar-20050423.ebuild,v 1.1 2005/04/24 04:57:07 kito Exp $

inherit eutils flag-o-matic

DESCRIPTION="The XAR project aims to provide an easily extensible archive format."
HOMEPAGE="http://www.opendarwin.org/projects/xar/"
SRC_URI="http://www.opendarwin.org/projects/xar/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
IUSE="debug"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	dev-libs/openssl
	dev-libs/libxml2
	sys-libs/zlib"

src_compile() {
	use debug && myconf="${myconf} --enable-symbols"
	use ppc64 && myconf="${myconf} --enable-64bit"
	use sparc && myconf="${myconf} --enable-64bit-vis"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
