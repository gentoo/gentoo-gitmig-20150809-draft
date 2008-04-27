# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libp11/libp11-0.2.2.ebuild,v 1.7 2008/04/27 03:45:15 drac Exp $

DESCRIPTION="Libp11 is a library implementing a small layer on top of PKCS#11 API
to make using PKCS#11 implementations easier."
HOMEPAGE="http://www.opensc-project.org/libp11/"
SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=""
DEPEND="dev-util/pkgconfig"

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dohtml doc/*.html doc/*.css
}
