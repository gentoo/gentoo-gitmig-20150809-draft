# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/m4/m4-1.4.14.ebuild,v 1.2 2010/03/20 09:33:26 the_paya Exp $

DESCRIPTION="GNU macro processor"
HOMEPAGE="http://www.gnu.org/software/m4/m4.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="examples"

# remember: cannot dep on autoconf since it needs us
DEPEND="|| ( app-arch/xz-utils app-arch/lzma-utils )"
RDEPEND=""

src_compile() {
	local myconf=""
	[[ ${USERLAND} != "GNU" ]] && myconf="--program-prefix=g"
	econf \
		--enable-changeword \
		${myconf} \
		|| die
	emake || die
}

src_test() {
	[[ -d /none ]] && die "m4 tests will fail with /none/" #244396
	emake check || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc BACKLOG ChangeLog NEWS README* THANKS TODO
	if use examples ; then
		docinto examples
		dodoc examples/*
		rm -f "${D}"/usr/share/doc/${PF}/examples/Makefile*
	fi
	rm -f "${D}"/usr/lib/charset.alias #172864
}
