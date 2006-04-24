# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/d4x/d4x-2.5.6.ebuild,v 1.4 2006/04/24 00:42:44 metalgod Exp $

IUSE="nls esd gnome oss kde"

inherit eutils flag-o-matic

DESCRIPTION="GTK based download manager for X."
SRC_URI="http://www.krasu.ru/soft/chuchelo/files/${P}.tar.gz"
HOMEPAGE="http://www.krasu.ru/soft/chuchelo/"

KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="Artistic"

DEPEND=">=x11-libs/gtk+-2.0.6
	>=dev-libs/glib-2.0.6
	>=sys-devel/gettext-0.11.2
	>=dev-libs/openssl-0.9.7e
	esd? ( >=media-sound/esound-0.2.7 )"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-libintl_fix.patch"

	# Use our own $CXXFLAGS
	cd ${S}
	cp configure configure.orig
	sed -e "s:CXXFLAGS=\"-O2\":CXXFLAGS=\"${CXXFLAGS}\":g;s:OPTFLAGS=\"-O2\":OPTFLAGS=\"\":g" \
		configure.orig >configure
}

src_compile() {

	myconf=""
	append-flags -D_FILE_OFFSET_BITS=64

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	use esd \
		&& myconf="${myconf} --enable-esd" \
		|| myconf="${myconf} --disable-esd"

	use oss \
		&& myconf="${myconf} --enable-oss" \
		|| myconf="${myconf} --disable-oss"

	econf --enable-release \
		${myconf} || die

	emake || die
}

src_install () {

	dodir /usr/bin
	dodir /usr/share/d4x

	einstall || die

	insinto /usr/share/pixmaps
	doins share/*.png share/*.xpm

	if use kde
	then
		insinto /usr/share/applnk/Internet
		newins share/nt.desktop d4x.desktop
	fi

	if use gnome
	then
		echo "Categories=Application;Network;" >> ${S}/share/nt.desktop
		insinto /usr/share/applications
		newins share/nt.desktop d4x.desktop
	fi

	rm -rf ${D}/usr/share/d4x/{FAQ*,INSTALL*,README*,LICENSE,NAMES,TROUBLES}
	dodoc AUTHORS COPYING ChangeLog* NEWS PLANS TODO \
		DOC/{FAQ*,LICENSE,NAMES,README*,TROUBLES,THANKS}
}
