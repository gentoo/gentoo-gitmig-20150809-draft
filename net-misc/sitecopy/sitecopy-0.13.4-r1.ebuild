# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sitecopy/sitecopy-0.13.4-r1.ebuild,v 1.10 2004/07/15 03:35:47 agriffis Exp $

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
	)"

src_compile() {
	local myconf=""
	if use xml && use xml2 ; then
		myconf="${myconf} --with-libxml2 --without-libxml1"
	else
	use xml \
		&& myconf="${myconf} --with-libxml1" \
		|| myconf="${myconf} --without-libxml1"
	use xml2 \
		&& myconf="${myconf} --with-libxml2" \
		|| myconf="${myconf} --without-libxml2"
	fi
	use ssl \
		&& myconf="${myconf} --with-ssl" \
		|| myconf="${myconf} --without-ssl"
	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	econf ${myconf} || die "econf failed"

	emake || die "emake failed"

	if use gnome; then
		econf ${myconf} --with-gnomefe || die "econf failed"

		# gnome compile fix
		sed -i -e "s:VERSION:PACKAGE_VERSION:" gnome/init.c
		sed -i -e "s:VERSION:PACKAGE_VERSION:" gnome/main.c
		echo "int fe_accept_cert(const ne_ssl_certificate *cert, int failures) { return 0; }" >> gnome/gcommon.c
		sed -i -e "s:-lglib:-lglib -lgthread:" Makefile

		emake || die "emake failed"
	fi
}

src_install() {
	make DESTDIR=${D} install-sitecopy || die "install failed"

	if use gnome; then
		make DESTDIR=${D} install-xsitecopy || die "install failed"
		dobin sitecopy
	fi
}
