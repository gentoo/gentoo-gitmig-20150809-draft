# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/libspf2/libspf2-1.2.5-r2.ebuild,v 1.7 2007/11/23 17:34:15 drac Exp $

inherit eutils

DESCRIPTION="libspf2 implements the Sender Policy Framework, a part of the SPF/SRS protocol pair."
HOMEPAGE="http://www.libspf2.org"
SRC_URI="http://www.libspf2.org/spf/libspf2-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/patch-libspf2-1.2.5-nointernal
	epatch "${FILESDIR}"/${P}-64bit.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc Changelog README TODO docs/*.txt docs/API
}
