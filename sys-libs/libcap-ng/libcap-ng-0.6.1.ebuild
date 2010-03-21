# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libcap-ng/libcap-ng-0.6.1.ebuild,v 1.4 2010/03/21 13:11:53 ranger Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="POSIX 1003.1e capabilities"
HOMEPAGE="http://people.redhat.com/sgrubb/libcap-ng/"
SRC_URI="http://people.redhat.com/sgrubb/libcap-ng/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="python"

COMMON_DEPEND="sys-apps/attr"
RDEPEND="${COMMON_DEPEND}
	python? ( dev-lang/python )"
DEPEND="${COMMON_DEPEND}
	sys-kernel/linux-headers
	python? ( dev-lang/swig dev-lang/python )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-gentoo.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable python) || die "econf failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	dodoc ChangeLog README
}
