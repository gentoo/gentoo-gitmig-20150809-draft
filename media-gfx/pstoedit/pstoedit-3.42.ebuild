# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pstoedit/pstoedit-3.42.ebuild,v 1.9 2007/04/04 20:21:00 gustavoz Exp $

inherit libtool eutils

DESCRIPTION="translates PostScript and PDF graphics into other vector formats"
HOMEPAGE="http://www.pstoedit.net/pstoedit"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~ppc ~ppc64 sparc ~x86"
# see bug #29724. please don't re-enable flash support until
# ming has the patches applied <obz@gentoo.org>
# IUSE="flash emf"
IUSE="plotutils emf"

DEPEND="sys-libs/zlib
	!amd64? ( emf? ( media-libs/libemf ) )
	media-libs/libpng
	media-libs/libexif
	plotutils? ( media-libs/plotutils )"
#	flash? ( media-libs/ming )"
RDEPEND="${DEPEND}
	virtual/ghostscript"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# need to remove the pedantic flag, see bug #39557
	sed -i -e "s/\-pedantic//" configure
	epatch "${FILESDIR}"/${PN}-m4-quoting.patch
	elibtoolize
}

src_compile() {
	local myconf="--without-swf"
	if ! use amd64 && use emf ; then
		myconf="${myconf} $(use_with emf)"
		# bug #29724
		[ -f /usr/include/libEMF/emf.h ] \
		&& myconf="${myconf} --with-libemf-include=/usr/include/libEMF"
	fi

	econf ${myconf} $(use_with plotutils libplot) || die "econf failed"
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc readme.txt
	dohtml changelog.htm index.htm doc/pstoedit.htm
	doman doc/pstoedit.1
}
