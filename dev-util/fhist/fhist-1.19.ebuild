# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/fhist/fhist-1.19.ebuild,v 1.2 2011/02/27 09:38:43 xarthisius Exp $

EAPI="3"

inherit eutils

DESCRIPTION="File history and comparison tools"
HOMEPAGE="http://fhist.sourceforge.net/fhist.html"
SRC_URI="http://fhist.sourceforge.net/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="test"

RDEPEND="
	dev-libs/libexplain
	sys-devel/gettext
	sys-apps/groff"
DEPEND="${RDEPEND}
	sys-devel/bison
	test? ( app-arch/sharutils )"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-ldflags.patch
}

src_install () {
	emake -j1 DESTDIR="${D}" \
		install || die "make install failed"

	dodoc README || die
}
