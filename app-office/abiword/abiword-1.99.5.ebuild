# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-1.99.5.ebuild,v 1.1 2003/08/27 16:25:02 foser Exp $

inherit eutils debug

IUSE="spell jpeg xml2 gnome"

S=${WORKDIR}/${P}/abi
# REMIND : usually -${PV} needs to be added 
S_P=${WORKDIR}/${PN}-plugins

DESCRIPTION="Fully featured yet light and fast cross platform word processor"
HOMEPAGE="http://www.abisource.com"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://sourceforge/${PN}/${PN}-plugins-${PV}.tar.bz2"

KEYWORDS="~x86 ~sparc ~alpha ~ppc"
LICENSE="GPL-2"
SLOT="2"

RDEPEND="virtual/x11
	virtual/xft
	>=media-libs/fontconfig-2.1
	>=dev-libs/libunicode-0.4-r1
	media-libs/libpng
	>=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	>=app-text/wv-0.7.6
	>=dev-libs/fribidi-0.10.4
	jpeg?  ( >=media-libs/jpeg-6b-r2 )
	( xml2? >=dev-libs/libxml2-2.4.10 : dev-libs/expat )
	spell? ( >=app-text/enchant-0.1 )
	gnome? ( >=gnome-base/libgnomeui-2.2 
		>=gnome-base/libgnomeprintui-2.2.1 
		>=gnome-extra/gal-1.99 )"

DEPEND="${RDEPEND}
	sys-devel/automake
	dev-util/pkgconfig"

#	>=dev-libs/libole2-0.2.4-r1
#	perl?  ( >=dev-lang/perl-5.6 )
# perl seems broken

src_compile() {
	./autogen.sh

	# this is a hack since I don't want to go hack in the gnome-vfs headerfiles.
	# The issue is about gnome-vfs containing "long long" which makes gcc 3.3.1 balk
	cp configure configure.old
	cat configure.old |sed s:-pedantic::g >configure	
	rm -f configure.old 

	econf \
		`use_enable gnome` \
		`use_with xml2 libxml2` \
		`use_enable spell enchant` \
		--enable-bidi \
		--without-ImageMagick \
		--disable-scripting \
		--with-sys-wv || die  

	emake all-recursive || die

	# Build plugins

	cd ${S_P}

	./nextgen.sh
	econf --enable-all --with-abiword=${S} || die
	emake || die

}

src_install() {  
	dodir /usr/{bin,lib}
	
	einstall PERLDEST=${D} || die
	
	dosed "s:${D}::g" /usr/bin/AbiWord-2.0
	
	rm -f ${D}/usr/bin/abiword-2.0
	rm -f ${D}/usr/bin/abiword
	dosym AbiWord-2.0 /usr/bin/abiword-2.0

	dodoc COPYING *.TXT docs/build/BUILD.TXT user/wp/readme.txt

	# install plugins

	cd ${S_P}

	make DESTDIR=${D} install || die

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	newins ${WORKDIR}/${P}/abidistfiles/icons/abiword_48.png AbiWord.png
	insinto /usr/share/applications/
	doins ${FILESDIR}/AbiWord2.desktop

}
