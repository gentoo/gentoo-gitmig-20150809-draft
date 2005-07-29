# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/a52dec/a52dec-0.7.4-r5.ebuild,v 1.5 2005/07/29 13:38:31 flameeyes Exp $

inherit eutils flag-o-matic libtool

DESCRIPTION="library for decoding ATSC A/52 streams used in DVD"
HOMEPAGE="http://liba52.sourceforge.net/"
SRC_URI="http://liba52.sourceforge.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ~ppc-macos ppc64 ~sparc ~x86"
IUSE="oss djbfft"

DEPEND=">=sys-devel/autoconf-2.5
	>=sys-devel/automake-1.8
	djbfft? ( sci-libs/djbfft )"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-build.patch
	epatch ${FILESDIR}/${P}-freebsd.patch

	export WANT_AUTOMAKE=1.8
	export WANT_AUTOCONF=2.5
	libtoolize --force --copy --automake || die "libtoolize"
	autoheader || die "autoheader"
	aclocal || die "aclocal"
	automake -a -f -c || die "automake"
	autoconf || die "autoconf"

	epunt_cxx
}

src_compile() {
	filter-flags -fprefetch-loop-arrays

	local myconf="--enable-shared"
	use oss || myconf="${myconf} --disable-oss"
	econf \
		$(use_enable djbfft) \
		${myconf} || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" docdir=/usr/share/doc/${PF}/html install || die

	insinto /usr/include/a52dec
	doins ${S}/liba52/a52_internal.h

	dodoc AUTHORS ChangeLog HISTORY NEWS README TODO doc/liba52.txt
}
