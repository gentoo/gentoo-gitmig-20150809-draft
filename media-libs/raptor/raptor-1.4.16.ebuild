# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/raptor/raptor-1.4.16.ebuild,v 1.1 2007/10/10 13:54:51 drac Exp $

inherit eutils

DESCRIPTION="The RDF Parser Toolkit"
HOMEPAGE="http://librdf.org/raptor"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="LGPL-2.1 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="curl unicode xml"

RDEPEND="unicode? ( >=dev-libs/glib-2 )
	xml? ( >=dev-libs/libxml2-2.6.8 )
	!xml? ( dev-libs/expat )
	curl? ( net-misc/curl )
	dev-libs/libxslt"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epunt_cxx
}

src_compile() {
	local myconf=""

	if use xml; then
		myconf="${myraptorconf} --with-xml-parser=libxml"
	else
		myconf="${myraptorconf} --with-xml-parser=expat"
	fi

	if use curl; then
		myconf="${myraptorconf} --with-www=curl"
	elif use xml; then
		myconf="${myraptorconf} --with-www=xml"
	else
		myconf="${myraptorconf} --with-www=none"
	fi

	econf $(use_enable unicode nfc-check) \
		${myraptorconf}
	
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS NOTICE README
	dohtml NEWS.html README.html RELEASE.html
}
