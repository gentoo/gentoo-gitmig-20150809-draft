# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-2.0.3-r1.ebuild,v 1.1 2004/02/18 15:59:40 foser Exp $

inherit eutils

IUSE="spell jpeg xml2 gnome debug doc"

S_P=${S}/${PN}-plugins
S_D=${S}/${PN}-docs
S=${WORKDIR}/${P}/abi

DESCRIPTION="Fully featured yet light and fast cross platform word processor"
HOMEPAGE="http://www.abisource.com"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

KEYWORDS="~x86 ~sparc ~alpha ~ppc"
LICENSE="GPL-2"
SLOT="2"

RDEPEND="virtual/x11
	virtual/xft
	>=media-libs/fontconfig-2.1
	media-libs/libpng
	>=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	>=app-text/wv-1
	>=dev-libs/fribidi-0.10.4
	jpeg?  ( >=media-libs/jpeg-6b-r2 )
	( xml2? >=dev-libs/libxml2-2.4.10 : dev-libs/expat )
	spell? ( >=app-text/enchant-1 )
	gnome? ( >=gnome-base/libgnomeui-2.2
		>=gnome-base/libgnomeprint-2.2.1
		>=gnome-base/libgnomeprintui-2.2.1
		>=gnome-base/libbonobo-2 )"

DEPEND="${RDEPEND}
	sys-devel/automake
	dev-util/pkgconfig"

src_compile() {

	# this is a hack since I don't want to go hack in the gnome-vfs headerfiles.
	# The issue is about gnome-vfs containing "long long" which makes gcc 3.3.1 balk
	cp configure configure.old
	cat configure.old |sed s:-pedantic::g >configure
	rm -f configure.old

	econf \
		`use_enable gnome` \
		`use_with xml2 libxml2` \
		`use_enable spell enchant` \
		`use_enable debug` \
		--enable-bidi \
		--enable-threads \
		--without-ImageMagick \
		--disable-scripting \
		--with-sys-wv || die

	emake all-recursive || die

	# Build plugins

	cd ${S_P}

	econf \
		`use_enable debug` \
		--enable-all \
		--with-abiword=${S} \
		--without-ImageMagick || die

	emake || die

}

src_install() {

	dodir /usr/{bin,lib}

	einstall PERLDEST=${D} || die

	dosed "s:Exec=abiword:Exec=abiword-2.0:" /usr/share/applications/abiword.desktop

	rm -f ${D}/usr/bin/abiword-2.0
	rm -f ${D}/usr/bin/abiword
	dosym AbiWord-2.0 /usr/bin/abiword-2.0

	dodoc COPYING *.TXT docs/build/BUILD.TXT user/wp/readme.txt

	# install plugins

	cd ${S_P}

	make DESTDIR=${D} install || die

	# install documentation

	use doc && (
		cd ${WORKDIR}/${P}/abiword-docs
		sed -e 's:prefix = /usr/local:prefix = /usr:g' Makefile > Makefile.new
		mv Makefile.new Makefile
		make DESTDIR=${D} || die
	)

}

USE_DESTDIR="1"
