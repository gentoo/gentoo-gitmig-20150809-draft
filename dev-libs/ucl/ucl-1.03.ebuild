# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ucl/ucl-1.03.ebuild,v 1.2 2005/01/12 04:14:37 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="UCL: The UCL Compression Library"
HOMEPAGE="http://www.oberhumer.com/opensource/ucl/"
SRC_URI="http://www.oberhumer.com/opensource/ucl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ppc64 ~ia64"
IUSE=""

src_compile() {
	epunt_cxx #76771

	# Doing this b/c UCL will be included in the kernel
	# at some point, and will be fixed properly then
	# besides, this is lu_zero's build
	append-flags -fPIC

	econf || die
	emake CFLAGS_O= || die
}

src_install() {
	make install DESTDIR=${D} || die
}
