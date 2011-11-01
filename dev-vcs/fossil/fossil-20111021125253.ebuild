# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/fossil/fossil-20111021125253.ebuild,v 1.1 2011/11/01 01:38:13 titanofold Exp $

EAPI="4"

MY_P="${PN}-src-${PV}"

DESCRIPTION="Simple, high-reliability, distributed software configuration management"
HOMEPAGE="http://www.fossil-scm.org/"
SRC_URI="http://www.fossil-scm.org/download/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sqlite +ssl"

DEPEND="sys-libs/zlib
		ssl? ( dev-libs/openssl )
		sqlite? ( dev-db/sqlite:3 )
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local myconf=' --with-openssl='
	use ssl    && myconf+='auto' || myconf+='none'
	use sqlite && myconf+=' --disable-internal-sqlite'

	econf ${myconf}
}

src_install() {
	dobin fossil
}
