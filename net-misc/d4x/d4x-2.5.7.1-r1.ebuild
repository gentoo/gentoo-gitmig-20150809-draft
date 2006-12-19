# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/d4x/d4x-2.5.7.1-r1.ebuild,v 1.2 2006/12/19 13:57:51 gustavoz Exp $

IUSE="nls esd gnome oss kde"

inherit eutils flag-o-matic

DESCRIPTION="GTK based download manager for X."
SRC_URI="http://d4x.krasu.ru/files/${P}.tar.bz2"
HOMEPAGE="http://www.krasu.ru/soft/chuchelo/"

KEYWORDS="~amd64 sparc ~x86"
SLOT="0"
LICENSE="Artistic"

DEPEND=">=x11-libs/gtk+-2.0.6
	>=dev-libs/glib-2.0.6
	>=sys-devel/gettext-0.11.2
	>=dev-libs/openssl-0.9.7e
	dev-libs/boost
	esd? ( >=media-sound/esound-0.2.7 )"

src_unpack() {

	unpack ${A}

	epatch "${FILESDIR}/${P}-libintl_fix.patch"
	epatch "${FILESDIR}/${P}-speed.patch"

	cd ${S}
	# Fix "implausibly old time stamp 1970-01-01 01:00:00":
	touch share/themes/gnome/popup/remove.png

	# Use our own $CXXFLAGS
	sed -i -e \
		"s:CXXFLAGS=\"-O2\":CXXFLAGS=\"${CXXFLAGS}\":g;s:OPTFLAGS=\"-O2\":OPTFLAGS=\"\":g" \
		configure

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

	rm -rf ${D}/usr/share/d4x/{FAQ*,INSTALL*,README*,LICENSE,AUTHORS,TROUBLES}
	dodoc AUTHORS COPYING ChangeLog* NEWS PLANS TODO \
		DOC/{FAQ*,LICENSE,README*,TROUBLES,THANKS}

}
