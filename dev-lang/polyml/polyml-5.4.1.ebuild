# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/polyml/polyml-5.4.1.ebuild,v 1.2 2012/01/08 15:25:53 gienah Exp $

EAPI="4"

inherit base

MY_P=${PN}.${PV}

DESCRIPTION="Poly/ML is a full implementation of Standard ML"
HOMEPAGE="http://www.polyml.org"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X +gmp portable +threads"

RDEPEND="X? ( x11-libs/openmotif )
		gmp? ( >=dev-libs/gmp-5 )
		threads? ( >=sys-libs/glibc-2.13 )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

PATCHES=("${FILESDIR}/${PN}-5.4.1-asm.patch")

src_configure() {
	econf \
		$(use_with X x) \
		$(use_with gmp) \
		$(use_with portable) \
		$(use_with threads)
}
