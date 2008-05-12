# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/sparse/sparse-0.4.1.ebuild,v 1.4 2008/05/12 16:12:46 corsair Exp $

inherit eutils multilib flag-o-matic

DESCRIPTION="C semantic parser"
HOMEPAGE="http://kernel.org/pub/linux/kernel/people/josh/sparse/"
SRC_URI="http://kernel.org/pub/linux/kernel/people/josh/sparse/dist/${P}.tar.gz"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="~amd64 arm ~hppa ia64 ~ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^PREFIX=/s:=.*:=/usr:' \
		-e "/^LIBDIR=/s:/lib:/$(get_libdir):" \
		Makefile || die
	append-flags -fno-strict-aliasing
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc FAQ README
}
