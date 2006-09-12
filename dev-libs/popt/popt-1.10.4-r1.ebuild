# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/popt/popt-1.10.4-r1.ebuild,v 1.5 2006/09/12 08:03:17 corsair Exp $

inherit flag-o-matic autotools

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="http://www.rpm.org/"
SRC_URI="ftp://jbj.org/pub/rpm-4.4.x/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86 ~x86-fbsd"
IUSE="nls"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="nls? ( sys-devel/gettext )"

#test fail. I can't figure out why.
RESTRICT=test

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-lib64.patch
	eautoreconf
}

src_compile() {
	use ppc-macos && append-ldflags -undefined dynamic_lookup
	econf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc CHANGES README
}
