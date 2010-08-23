# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/raptor/raptor-1.4.21.ebuild,v 1.3 2010/08/23 19:11:25 ssuominen Exp $

EAPI=3
inherit eutils libtool

DESCRIPTION="The RDF Parser Toolkit"
HOMEPAGE="http://librdf.org/raptor"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="LGPL-2.1 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="curl debug static-libs unicode xml"

RDEPEND="unicode? ( dev-libs/glib:2 )
	xml? ( >=dev-libs/libxml2-2.6.8 )
	!xml? ( dev-libs/expat )
	curl? ( net-misc/curl )
	dev-libs/libxslt"
DEPEND="${RDEPEND}
	sys-devel/flex
	dev-util/pkgconfig"

src_prepare() {
	epunt_cxx
	elibtoolize # Required by FreeBSD .so versioning
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
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS NOTICE README
	dohtml NEWS.html README.html RELEASE.html
	find "${ED}" -name '*.la' -exec rm -f '{}' +
}
