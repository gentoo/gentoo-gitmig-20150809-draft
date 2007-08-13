# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/raptor/raptor-1.4.15.ebuild,v 1.5 2007/08/13 21:10:38 dertobi123 Exp $

inherit eutils

DESCRIPTION="The RDF Parser Toolkit"
HOMEPAGE="http://librdf.org/raptor/"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="LGPL-2.1 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ia64 ppc ~ppc-macos ~ppc64 ~sparc x86"
IUSE="curl xml gnome ssl"

DEPEND="virtual/libc
	gnome? ( >=dev-libs/glib-2.2.1 dev-util/pkgconfig )
	xml? ( >=dev-libs/libxml2-2.4.0 )
	!xml? ( dev-libs/expat )
	ssl? ( dev-libs/openssl )
	curl? ( net-misc/curl )"
RDEPEND="virtual/libc
	gnome? ( >=dev-libs/glib-2.2.1 )
	xml? ( >=dev-libs/libxml2-2.4.0 )
	!xml? ( dev-libs/expat )
	ssl? ( dev-libs/openssl )
	curl? ( net-misc/curl )"

# compilation with libwww currently breaks and for using libfetch I didn't find the right USE flag
#IUSE="curl xml libwww gnome"
#DEPEND="virtual/libc
#	gnome? ( >=dev-libs/glib-2.2.1 dev-util/pkgconfig )
#	xml? ( >=dev-libs/libxml2-2.4.0 ) : ( dev-libs/expat )
#	ssl? ( dev-libs/openssl )
#	curl? ( net-misc/curl ) : ( !xml? ( libwww? ( net-libs/libwww ) ) )
#	"
#RDEPEND="virtual/libc
#	gnome? ( >=dev-libs/glib-2.2.1 )
#	xml? ( >=dev-libs/libxml2-2.4.0 ) : ( dev-libs/expat )
#	ssl? ( dev-libs/openssl )
#	curl? ( net-misc/curl ) : ( !xml? ( libwww? ( net-libs/libwww ) ) )"

src_unpack() {
	unpack ${A}
	epunt_cxx
}

src_compile() {
	local myraptorconf=""

	use xml \
		&& myraptorconf="${myraptorconf} --with-xml-parser=libxml" \
		|| myraptorconf="${myraptorconf} --with-xml-parser=expat"

	if use curl ; then
		myraptorconf="${myraptorconf} --with-www=curl"
	elif use xml ; then
		myraptorconf="${myraptorconf} --with-www=xml"
#	elif use libwww ;
#		myraptorconf="${myraptorconf} --with-www=libwww"
	else
		myraptorconf="${myraptorconf} --with-www=none"
	fi
	econf \
		$(use_enable gnome nfc-check) \
		${myraptorconf} \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
	dohtml NEWS.html README.html
}
