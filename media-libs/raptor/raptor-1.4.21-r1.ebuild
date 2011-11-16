# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/raptor/raptor-1.4.21-r1.ebuild,v 1.15 2011/11/16 18:32:49 ssuominen Exp $

EAPI=4
inherit eutils libtool

DESCRIPTION="The RDF Parser Toolkit"
HOMEPAGE="http://librdf.org/raptor"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="Apache-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc ppc64 x86 ~x86-fbsd ~x64-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="+curl debug static-libs unicode +xml"

RDEPEND="unicode? ( dev-libs/glib:2 )
	xml? ( >=dev-libs/libxml2-2.6.8 )
	!xml? ( dev-libs/expat )
	curl? ( net-misc/curl )
	dev-libs/libxslt"
DEPEND="${RDEPEND}
	sys-devel/flex
	dev-util/pkgconfig"

src_prepare() {
	sed -i -e '/CPPFLAGS/s:-g::' configure || die #376903
	epatch "${FILESDIR}"/${PN}-2.0.3-curl-headers.patch
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
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_enable unicode nfc-check) \
		$(use_enable debug) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install

	find "${ED}" -name '*.la' -exec rm -f {} +

	# Reduce installation of obsolete raptor1 to only mandatory files
	rm -rf \
		"${ED}"usr/bin/rapper \
		"${ED}"usr/share
}
