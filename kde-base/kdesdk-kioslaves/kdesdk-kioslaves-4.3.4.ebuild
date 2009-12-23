# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-kioslaves/kdesdk-kioslaves-4.3.4.ebuild,v 1.2 2009/12/23 00:06:22 abcd Exp $

EAPI="2"

KMNAME="kdesdk"
KMMODULE="kioslave"
inherit kde4-meta

DESCRIPTION="kioslaves from kdesdk package: the subversion kioslave"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	dev-libs/apr
	dev-util/subversion
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DAPRCONFIG_EXECUTABLE="${EPREFIX}"/usr/bin/apr-1-config
	)

	kde4-meta_src_configure
}
