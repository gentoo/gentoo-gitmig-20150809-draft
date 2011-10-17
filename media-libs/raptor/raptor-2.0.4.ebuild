# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/raptor/raptor-2.0.4.ebuild,v 1.5 2011/10/17 14:29:57 jer Exp $

EAPI=4
inherit autotools eutils libtool

MY_P=${PN}2-${PV}

DESCRIPTION="The RDF Parser Toolkit"
HOMEPAGE="http://librdf.org/raptor/"
SRC_URI="http://download.librdf.org/source/${MY_P}.tar.gz"

LICENSE="Apache-2.0 GPL-2 LGPL-2.1"
SLOT="2"
KEYWORDS="amd64 ~arm hppa ~ppc ~ppc64 x86 ~x86-fbsd ~x64-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="+curl debug json static-libs unicode +xml"

RDEPEND="unicode? ( dev-libs/glib:2 )
	xml? ( >=dev-libs/libxml2-2.6.8 )
	!xml? ( dev-libs/expat )
	curl? ( net-misc/curl )
	json? ( dev-libs/yajl )
	dev-libs/libxslt
	!<media-libs/raptor-1.4.21-r1"
DEPEND="${RDEPEND}
	sys-devel/flex
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

DOCS=( AUTHORS ChangeLog NEWS NOTICE README )

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix_math_test.patch
	eautoreconf # only for -fix_math_test.patch
	epunt_cxx
	elibtoolize
}

src_configure() {
	local myconf

	if use xml; then
		myconf+=" --with-xml-parser=libxml"
	else
		myconf+=" --with-xml-parser=expat"
	fi

	if use curl; then
		myconf+=" --with-www=curl"
	elif use xml; then
		myconf+=" --with-www=xml"
	else
		myconf+=" --with-www=none"
	fi

	econf \
		$(use_enable static-libs static) \
		$(use_enable unicode nfc-check) \
		$(use_enable debug) \
		$(use_with json yajl) \
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html \
		${myconf}
}

src_install() {
	default
	dohtml {NEWS,README,RELEASE,UPGRADING}.html
	find "${ED}" -name '*.la' -exec rm -f {} +
}
