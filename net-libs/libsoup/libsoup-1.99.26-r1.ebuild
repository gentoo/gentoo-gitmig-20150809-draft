# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsoup/libsoup-1.99.26-r1.ebuild,v 1.9 2004/02/04 18:23:50 liquidx Exp $

inherit gnome.org libtool

DESCRIPTION="Soup is a SOAP implementation"
HOMEPAGE="http://www.gnome.org/"

IUSE="gnutls"
SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc  ppc ~alpha hppa ia64 amd64"

RDEPEND=">=dev-libs/glib-2.0
	!gnutls? ( dev-libs/openssl )
	gnutls?  ( net-libs/gnutls )"

DEPEND=">=dev-util/pkgconfig-0.12.0
	dev-libs/popt
	sys-devel/automake
	sys-devel/autoconf
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-msn.patch
	EPATCH_OPTS="-d ${S}"  epatch ${FILESDIR}/${P}-gnutls_1.0.patch
	# added --with-ssl=openssl|gnutls to choose between the two.
	export WANT_AUTOCONF=1.4
	epatch ${FILESDIR}/${P}-with_ssl.patch
	cd ${S}; autoconf
}

src_compile() {
	local myconf
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
	dodoc AUTHORS COPYING* ChangeLog README* TODO
}
