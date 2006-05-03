# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdc1394/libdc1394-2.0.0_pre6-r2.ebuild,v 1.1 2006/05/03 14:05:49 seemant Exp $

inherit eutils

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="library for controling IEEE 1394 conforming based cameras"
HOMEPAGE="http://sourceforge.net/projects/libdc1394/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="X"

RDEPEND=">=sys-libs/libraw1394-1.2.0
		X? ( || ( ( x11-libs/libSM x11-libs/libXv )
				  virtual/x11 ) )"
DEPEND="!=sys-libs/libdc1394-2.0.0*
	${RDEPEND}
	sys-devel/libtool"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix a bug where iso_channel property is not kept up-to-date
	epatch ${FILESDIR}/${P}-grab_partial_image.diff
	epatch ${FILESDIR}/${P}-vendor_avt.diff
	epatch ${FILESDIR}/${P}-extra-failure-removal.diff
}

src_compile() {
	if has_version '>=sys-libs/glibc-2.4' ; then
		append-flags "-DCLK_TCK=CLOCKS_PER_SEC"
	fi
	econf \
		--program-suffix=2 \
		$(use_with X x) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc NEWS README AUTHORS ChangeLog
}
