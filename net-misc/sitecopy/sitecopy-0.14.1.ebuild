# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sitecopy/sitecopy-0.14.1.ebuild,v 1.1 2004/09/16 22:17:26 chriswhite Exp $

inherit eutils

IUSE="ssl xml xml2 gnome nls"

DESCRIPTION="sitecopy is for easily maintaining remote web sites"
SRC_URI="http://www.lyra.org/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.lyra.org/sitecopy/"
KEYWORDS="~x86 ~ppc ~sparc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc
	>=sys-libs/zlib-1.1.3
	xml? ( dev-libs/libxml )
	dev-libs/libxml2
	ssl? ( >=dev-libs/openssl-0.9.6 )
	gnome? (
		gnome-base/gnome-libs
		=x11-libs/gtk+-1*
	)
	>=net-misc/neon-0.24.6"

src_compile() {

	local myconf=""
	use xml && myconf="${myconf} $(use_with xml libxml1)"
	if use xml && use xml2 ; then
		myconf="${myconf} --with-libxml2 --without-libxml1"
	else
		myconf="${myconf} $(use_with xml2 libxml2)"
	fi

	# Bug 51585, GLSA 200406-03
	einfo "Forcing the use of the system-wide neon library (BR #51585)."
	myconf="${myconf} --with-neon"

	econf ${myconf} \
			$(use_with ssl) \
			$(use_enable nls) \
			$(use_enable gnome gnomefe) \
			|| die "configuration failed"

	# fixes some gnome compile issues
	if use gnome
	then
		echo "int fe_accept_cert(const ne_ssl_certificate *cert, int failures) { return 0; }" >> gnome/gcommon.c
		sed -i -e "s:-lglib:-lglib -lgthread:" Makefile
	fi

	# fix NLS compilation issue
	epatch ${FILESDIR}/${P}-nls.patch

	emake || die "Make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
}
