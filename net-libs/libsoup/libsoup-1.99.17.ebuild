# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsoup/libsoup-1.99.17.ebuild,v 1.2 2003/04/30 23:37:52 liquidx Exp $

#IUSE="ssl"
IUSE=""

inherit gnome.org libtool

S="${WORKDIR}/${P}"
DESCRIPTION="Soup is a SOAP implementation"
HOMEPAGE="http://www.gnome.org/"

SLOT="2"
RDEPEND=">=dev-libs/glib-2.0
	dev-libs/openssl"
DEPEND=">=dev-util/pkgconfig-0.12.0
	dev-libs/popt
    ${RDEPEND}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc  ~ppc ~alpha"

src_compile() {
	elibtoolize

	local myconf=""
	
	# current build system deems ssl as NOT AN OPTION.
	# use ssl && myconf="--enable-ssl --enable-openssl"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING* ChangeLog README* TODO
}
