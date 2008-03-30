# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/m4/m4-1.4.10-r1.ebuild,v 1.7 2008/03/30 12:35:13 coldwind Exp $

inherit eutils

DESCRIPTION="GNU macro processor"
HOMEPAGE="http://www.gnu.org/software/m4/m4.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2
	ftp://ftp.seindal.dk/gnu/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="examples nls"

# remember: cannot dep on autoconf since it needs us
DEPEND="nls? ( sys-devel/gettext )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix for BSD systems pulled from upstream.
	epatch "${FILESDIR}/${P}"-seek.patch
}

src_compile() {
	local myconf=""
	[ "${USERLAND}" != "GNU" ] && myconf="--program-prefix=g"
	econf \
		$(use_enable nls) \
		--enable-changeword \
		${myconf} \
		|| die
	emake || die
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
