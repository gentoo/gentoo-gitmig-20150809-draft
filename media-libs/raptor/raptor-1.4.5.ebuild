# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/raptor/raptor-1.4.5.ebuild,v 1.1 2005/02/06 22:11:14 vapier Exp $

DESCRIPTION="The RDF Parser Toolkit"
HOMEPAGE="http://librdf.org/raptor/"
SRC_URI="http://librdf.org/dist/source/${P}.tar.gz"

LICENSE="LGPL-2 Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc-macos sparc x86 ~ppc64"
IUSE="curl xml2 gnome ssl"

DEPEND="virtual/libc
	gnome? ( >=dev-libs/glib-2.2.1 dev-util/pkgconfig )
	xml2? ( >=dev-libs/libxml2-2.4.0 )
	!xml2? ( dev-libs/expat )
	ssl? ( dev-libs/openssl )
	curl? ( net-misc/curl )"
RDEPEND="virtual/libc
	gnome? ( >=dev-libs/glib-2.2.1 )
	xml2? ( >=dev-libs/libxml2-2.4.0 )
	!xml2? ( dev-libs/expat )
	ssl? ( dev-libs/openssl )
	curl? ( net-misc/curl )"

# compilation with libwww currently breaks and for using libfetch I didn't find the right USE flag
#IUSE="curl xml2 libwww gnome"  
#DEPEND="virtual/libc
#	gnome? ( >=dev-libs/glib-2.2.1 dev-util/pkgconfig )
#	xml2? ( >=dev-libs/libxml2-2.4.0 ) : ( dev-libs/expat )
#	ssl? ( dev-libs/openssl )
#	curl? ( net-misc/curl ) : ( !xml2? ( libwww? ( net-libs/libwww ) ) )
#		"
#RDEPEND="virtual/libc
#	gnome? ( >=dev-libs/glib-2.2.1 )
#	xml2? ( >=dev-libs/libxml2-2.4.0 ) : ( dev-libs/expat )
#	ssl? ( dev-libs/openssl )
#	curl? ( net-misc/curl ) : ( !xml2? ( libwww? ( net-libs/libwww ) ) )"

DOC="AUTHORS ChangeLog INSTALL NEWS README"
HTML="INSTALL.html NEWS.html README.html"

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
