# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/fcgi/fcgi-2.4.0-r1.ebuild,v 1.5 2006/11/12 03:46:08 vapier Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit autotools eutils

DESCRIPTION="FastCGI Developer's Kit"
HOMEPAGE="http://www.fastcgi.com/"
SRC_URI="http://www.fastcgi.com/dist/${P}.tar.gz"

LICENSE="FastCGI"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 sh ~sparc ~x86 ~x86-fbsd"
IUSE="html"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/fcgi-2.4.0-Makefile.patch"
	epatch "${FILESDIR}/fcgi-2.4.0-clientdata-pointer.patch"

	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install LIBRARY_PATH="${D}"/usr/lib || die

	dodoc README

	# install the manpages into the right place
	doman doc/*.[13]

	# Only install the html documentation if USE=html
	use html && dohtml doc/*/*

	# install examples in the right place
	insinto /usr/share/doc/${PF}/examples
	doins examples/*.c
}
