# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pstoedit/pstoedit-3.42.ebuild,v 1.5 2006/07/07 10:03:15 jer Exp $

inherit libtool eutils

# see bug #29724. please don't re-enable flash support until
# ming has the patches applied <obz@gentoo.org>
# IUSE="flash emf"
IUSE="plotutils emf"

DESCRIPTION="translates PostScript and PDF graphics into other vector formats"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.pstoedit.net/pstoedit"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

DEPEND="sys-libs/zlib
	!amd64? ( emf? ( media-libs/libemf ) )
	media-libs/libpng
	media-libs/libexif
	plotutils? ( media-libs/plotutils )"
#	flash? ( media-libs/ming )"

RDEPEND="${DEPEND}
	virtual/ghostscript"

src_unpack() {

	unpack ${A}; cd ${S}
	# need to remove the pedantic flag, see bug #39557
	sed -i -e "s/\-pedantic//" configure
	epatch ${FILESDIR}/${PN}-m4-quoting.patch
}

src_compile() {

	local myconf=""
	if ! use amd64 && use emf ; then
		myconf="${myconf} $(use_with emf)"
		# bug #29724
		[ -f /usr/include/libEMF/emf.h ] \
		&& myconf="${myconf} --with-libemf-include=/usr/include/libEMF"
	fi

	elibtoolize
	econf ${myconf} $(use_with plotutils libplot) || die "econf failed"
	make || die

}

src_install () {

	make DESTDIR=${D} install || die "make install failed"
	dodoc readme.txt copying
	dohtml changelog.htm index.htm doc/pstoedit.htm
	doman doc/pstoedit.1

}
