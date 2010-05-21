# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gts/gts-20100321.ebuild,v 1.1 2010/05/21 12:21:23 jlec Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="GNU Triangulated Surface Library"
LICENSE="LGPL-2"
HOMEPAGE="http://gts.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples test"

RDEPEND="
	>=dev-libs/glib-2.4.0
	!dev-vcs/rcs
	!sys-apps/coreutil
	!<=sci-chemistry/ccp4-apps-6.1.3-r2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( media-libs/netpbm )"

# tests are failing
RESTRICT="test"

S="${WORKDIR}"/${PN}-snapshot-100321

src_prepare() {
	chmod +x test/*/*.sh
	epatch "${FILESDIR}"/${P}-examples.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO || die

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c || die "Failed to install examples"
	fi

	# install additional docs
	if use doc; then
		dohtml doc/html/* || die
	fi
}
