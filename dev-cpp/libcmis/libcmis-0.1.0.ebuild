# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libcmis/libcmis-0.1.0.ebuild,v 1.3 2011/11/30 12:34:43 xarthisius Exp $

EAPI=4

EGIT_REPO_URI="git://gitorious.org/libcmis/libcmis.git"
[[ ${PV} == 9999 ]] && SCM_ECLASS="git-2"
inherit autotools ${SCM_ECLASS}
unset SCM_ECLASS

DESCRIPTION="C++ client library for the CMIS interface"
HOMEPAGE="http://gitorious.org/libcmis"
[[ ${PV} == 9999 ]] || SRC_URI="http://people.freedesktop.org/~cbosdo/${PN}/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 MPL-1.1 )"
SLOT="0"
[[ ${PV} == 9999 ]] || KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs test"

RDEPEND="
	dev-libs/boost
	dev-libs/libxml2
	net-misc/curl
"
DEPEND="${RDEPEND}
	test? ( dev-util/cppunit )
"

# It fetches the apache chemistry webapp and then try to run some magic on it
RESTRICT="test"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--disable-werror \
		$(use_enable static-libs static) \
		$(use_enable test tests) \
		--enable-client
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
