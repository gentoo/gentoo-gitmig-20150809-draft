# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsoup/libsoup-1.99.28-r1.ebuild,v 1.2 2005/07/06 07:53:26 leonardop Exp $

inherit gnome.org libtool eutils

DESCRIPTION="Soup is a SOAP implementation"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc x86"
IUSE="gnutls static"

RDEPEND=">=dev-libs/glib-2.0
	!gnutls? ( dev-libs/openssl )
	gnutls?  ( >=net-libs/gnutls-1 )"
DEPEND=">=dev-util/pkgconfig-0.12.0
	dev-libs/popt
	sys-devel/automake
	sys-devel/autoconf
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-1.99.26-msn.patch
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${P}-gnutls.patch
	# added --with-ssl=openssl|gnutls to choose between the two.
	export WANT_AUTOCONF=1.4
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-1.99.26-with_ssl.patch
	cd ${S}; autoconf
}

src_compile() {
	local myconf="$(use_enable static) $(use_enable static static-ssl)"
	elibtoolize

	# current build system deems ssl as NOT AN OPTION.
	# use ssl && myconf="--enable-ssl --enable-openssl"
	use gnutls \
		&& myconf="${myconf} --with-ssl=gnutls" \
		|| myconf="${myconf} --with-ssl=openssl"

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
	dodoc AUTHORS ChangeLog README* TODO
}
