# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/a52dec/a52dec-0.7.4-r3.ebuild,v 1.2 2004/11/05 09:30:47 eradicator Exp $

IUSE="oss static djbfft"

inherit eutils flag-o-matic libtool gnuconfig

DESCRIPTION="library for decoding ATSC A/52 streams used in DVD"
HOMEPAGE="http://liba52.sourceforge.net/"
SRC_URI="http://liba52.sourceforge.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"

DEPEND=">=sys-devel/autoconf-2.5
	>=sys-devel/automake-1.8
	djbfft? ( dev-libs/djbfft )"

RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-build.patch
	export WANT_AUTOMAKE=1.8
	export WANT_AUTOCONF=2.5

	libtoolize --force --copy --automake

	autoheader
	aclocal
	automake -a -f -c
	autoconf

	gnuconfig_update
}

src_compile() {
	filter-flags -fprefetch-loop-arrays

	local myconf="--enable-shared"
	use oss || myconf="${myconf} --disable-oss"
	econf 	$(use_enable static) \
		$(use_enable djbfft) \
		${myconf} || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" docdir=/usr/share/doc/${PF}/html install || die
	dodoc AUTHORS ChangeLog HISTORY NEWS README TODO doc/liba52.txt
}
