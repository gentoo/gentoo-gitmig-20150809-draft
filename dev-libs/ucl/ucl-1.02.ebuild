# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ucl/ucl-1.02.ebuild,v 1.9 2007/08/25 17:38:50 beandog Exp $

inherit flag-o-matic

DESCRIPTION="UCL: The UCL Compression Library"
HOMEPAGE="http://www.oberhumer.com/opensource/ucl/"
SRC_URI="http://www.oberhumer.com/opensource/ucl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 ~sparc x86"
IUSE=""

src_compile() {
	# Doing this b/c UCL will be included in the kernel
	# at some point, and will be fixed properly then
	# besides, this is lu_zero's build
	append-flags -fPIC

	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
}
