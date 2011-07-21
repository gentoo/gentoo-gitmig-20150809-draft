# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/flickcurl/flickcurl-1.21.ebuild,v 1.1 2011/07/21 08:31:34 radhermit Exp $

EAPI="4"

inherit autotools

DESCRIPTION="C library for the Flickr API"
HOMEPAGE="http://librdf.org/flickcurl/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
# Regular tarball is missing a header file breaking non-raptor support
#SRC_URI="http://download.dajobe.org/flickcurl/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 GPL-2 Apache-2.0 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc raptor static-libs"

RDEPEND=">=net-misc/curl-7.10.0
	>=dev-libs/libxml2-2.6.8:2
	raptor? ( media-libs/raptor:2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	if ! use doc ; then
		# Only install html documentation when the use flag is enabled
		sed -i -e '/gtk-doc.make/d' \
			-e 's:+=:=:' docs/Makefile.am || die
	else
		# Install html docs in the correct directory
		sed -i -e '/^TARGET_DIR/s:/$(DOC_MODULE)::' gtk-doc.make || die
	fi

	eautoreconf
}

src_configure() {
	local myconf
	if use raptor ; then
		myconf="--with-raptor=2"
	else
		myconf="--with-raptor=no"
	fi

	econf \
		--with-html-dir=/usr/share/doc/${PF}/html \
		$(use_enable static-libs static) \
		${myconf}
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f '{}' +
}
