# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-exec/python-exec-0.1.ebuild,v 1.4 2012/10/16 01:31:32 blueness Exp $

EAPI=4

inherit autotools-utils python-r1

DESCRIPTION="Python script wrapper"
HOMEPAGE="https://bitbucket.org/mgorny/python-exec/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~x86"
IUSE=""

append_impl() {
	pyimpls+="${EPYTHON} "
}

src_configure() {
	local pyimpls
	python_foreach_impl append_impl

	local myeconfargs=(
		--with-python-impls="${pyimpls}"
	)

	autotools-utils_src_configure
}
