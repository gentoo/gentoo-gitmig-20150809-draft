# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-exec/python-exec-0.1.ebuild,v 1.8 2012/10/21 06:46:11 ryao Exp $

EAPI=4

inherit autotools-utils python-r1

DESCRIPTION="Python script wrapper"
HOMEPAGE="https://bitbucket.org/mgorny/python-exec/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
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
