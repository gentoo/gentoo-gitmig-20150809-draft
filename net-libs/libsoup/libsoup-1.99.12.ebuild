# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsoup/libsoup-1.99.12.ebuild,v 1.1 2003/03/14 00:16:56 liquidx Exp $

IUSE="ssl"

inherit libtool

S="${WORKDIR}/${P}"
DESCRIPTION="Soup is a SOAP implementation"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.ximian.com/pub/ximian-evolution-beta/source/${P}.tar.gz"

SLOT="2"
RDEPEND=">=dev-libs/glib-2.0
	ssl? ( dev-libs/openssl )"
DEPEND=">=dev-util/pkgconfig-0.12.0
	dev-libs/popt
    ${RDEPEND}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc  ~ppc ~alpha"

src_compile() {
	elibtoolize

	local myconf=""
    
	if [ -n "`use ssl`" ]; then
		myconf="${myconf} --enable-ssl --enable-openssl"
		# or alternatively use --enable-nss (mozilla)
	else
		myconf="${myconf} --disable-ssl"
	fi

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING* ChangeLog README* TODO
}
