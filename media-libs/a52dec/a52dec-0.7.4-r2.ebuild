# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/a52dec/a52dec-0.7.4-r2.ebuild,v 1.2 2004/10/04 08:37:13 eradicator Exp $

inherit flag-o-matic

DESCRIPTION="library for decoding ATSC A/52 streams used in DVD"
HOMEPAGE="http://liba52.sourceforge.net/"
SRC_URI="http://liba52.sourceforge.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
IUSE="oss static djbfft"

DEPEND=">=sys-devel/autoconf-2.52d-r1
	djbfft? ( dev-libs/djbfft )"
RDEPEND="virtual/libc"

src_compile() {
	append-flags -fPIC
	filter-flags -fprefetch-loop-arrays

	local myconf="--enable-shared"
	use oss || myconf="${myconf} --disable-oss"
	econf 	$(use_enable static) \
		$(use_enable djbfft) \
		${myconf} || die
	emake || die "emake failed"
}

src_install() {
	einstall docdir=${D}/usr/share/doc/${PF}/html || die
	dodoc AUTHORS ChangeLog HISTORY NEWS README TODO doc/liba52.txt
}
