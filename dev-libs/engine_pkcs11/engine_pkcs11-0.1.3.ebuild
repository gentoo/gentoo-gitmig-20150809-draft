# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/engine_pkcs11/engine_pkcs11-0.1.3.ebuild,v 1.9 2007/07/12 02:25:34 mr_bones_ Exp $

DESCRIPTION="engine_pkcs11 is an implementation of an engine for OpenSSL"
HOMEPAGE="http://www.opensc-project.org/"
SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-libs/libp11"
RDEPEND="${DEPEND}"

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dohtml doc/*.html doc/*.css
}
