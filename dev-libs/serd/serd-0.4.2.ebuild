# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/serd/serd-0.4.2.ebuild,v 1.1 2011/05/27 05:31:27 aballier Exp $

EAPI=3

inherit base multilib

DESCRIPTION="Library for RDF syntax which supports reading and writing Turtle and NTriples"
HOMEPAGE="http://drobilla.net/software/serd/"
SRC_URI="http://download.drobilla.net/${P}.tar.bz2"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc test"

RDEPEND=""
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

PATCHES=( "${FILESDIR}/ldconfig.patch" )

src_configure() {
	./waf configure \
		--prefix=/usr \
		--libdir="/usr/$(get_libdir)" \
		--mandir=/usr/share/man \
		--docdir=/usr/share/doc/${PF} \
		$(use debug && echo "--debug") \
		$(use test && echo "--test") \
		$(use doc && echo "--docs") \
		|| die
}

src_compile() {
	./waf || die
}

src_test() {
	./waf test || die
}

src_install() {
	./waf install --destdir="${D}" || die
	dodoc AUTHORS README ChangeLog || die
}
