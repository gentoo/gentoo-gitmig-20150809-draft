# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/raptor/raptor-1.2.0.ebuild,v 1.6 2004/03/31 17:33:57 eradicator Exp $

DESCRIPTION="The RDF Parser Toolkit"
HOMEPAGE="http://www.redland.opensource.ac.uk/raptor/"
SRC_URI="http://www.redland.opensource.ac.uk/dist/source/${P}.tar.gz"

LICENSE="LGPL-2 MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="curl xml2 gnome ssl"

DEPEND="virtual/glibc
	gnome? ( >=dev-libs/glib-2.2.1 dev-util/pkgconfig )
	xml2? ( >=dev-libs/libxml2-2.4.0 )
	!xml2? ( dev-libs/expat )
	ssl? ( dev-libs/openssl )
	curl? ( net-misc/curl )"
RDEPEND="virtual/glibc
	gnome? ( >=dev-libs/glib-2.2.1 )
	xml2? ( >=dev-libs/libxml2-2.4.0 )
	!xml2? ( dev-libs/expat )
	ssl? ( dev-libs/openssl )
	curl? ( net-misc/curl )"

# compilation with libwww currently breaks and for using libfetch I didn't find the right USE flag
#IUSE="curl xml2 libwww gnome"  
#DEPEND="virtual/glibc
#	gnome? ( >=dev-libs/glib-2.2.1 dev-util/pkgconfig )
#	xml2? ( >=dev-libs/libxml2-2.4.0 ) : ( dev-libs/expat )
#	ssl? ( dev-libs/openssl )
#	curl? ( net-misc/curl ) : ( !xml2? ( libwww? ( net-libs/libwww ) ) )
#		"
#RDEPEND="virtual/glibc
#	gnome? ( >=dev-libs/glib-2.2.1 )
#	xml2? ( >=dev-libs/libxml2-2.4.0 ) : ( dev-libs/expat )
#	ssl? ( dev-libs/openssl )
#	curl? ( net-misc/curl ) : ( !xml2? ( libwww? ( net-libs/libwww ) ) )"

DOC="AUTHORS COPYING COPYING.LIB ChangeLog INSTALL LICENSE.txt NEWS README"
HTML="INSTALL.html LICENSE.html MPL.html NEWS.html README.html"

src_compile() {
	myraptorconf=""

	use xml2 \
		&& myraptorconf="${myraptorconf} --with-xml-parser=libxml" \
		|| myraptorconf="${myraptorconf} --with-xml-parser=expat"

	use curl && myraptorconf="${myraptorconf} --with-www=curl" \
		|| use xml2 && myraptorconf="${myraptorconf} --with-www=xml" \
		|| myraptorconf="${myraptorconf} --with-www=none"
#		|| use libwww && myraptorconf="${myraptorconf} --with-www=libwww" \
	econf \
	`use_enable gnome nfc-check` \
	${myraptorconf} \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc ${DOC}
	dohtml ${HTML}
}
