# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-1.99.2.ebuild,v 1.1 2003/07/27 18:17:43 foser Exp $

inherit eutils debug

IUSE="spell jpeg xml2 gnome"

S=${WORKDIR}/${P}/abi
S_P=${WORKDIR}/${PN}-plugins-${PV}

DESCRIPTION="Fully featured yet light and fast cross platform word processor"
HOMEPAGE="http://www.abisource.com"

#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/${PN}-plugins-${PV}.tar.gz"

KEYWORDS="~x86 ~sparc ~alpha ~ppc"
LICENSE="GPL-2"
SLOT="2"

RDEPEND="virtual/x11
	virtual/xft
	>=media-libs/fontconfig-2.1
	media-libs/libpng
	>=dev-libs/libunicode-0.4-r1
	>=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	>=app-text/wv-0.7.6
	>=dev-libs/fribidi-0.10.4
	jpeg?  ( >=media-libs/jpeg-6b-r2 )
	( xml2? >=dev-libs/libxml2-2.4.10 : dev-libs/expat )
	spell? ( >=app-text/aspell-0.50.3 )
	gnome? ( >=gnome-base/libgnomeui-2.2 
		>=gnome-base/libgnomeprintui-2.2.1 
		>=gnome-extra/gal-1.99 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

#	>=dev-libs/libole2-0.2.4-r1
#	perl?  ( >=dev-lang/perl-5.6 )
# perl seems broken

# FIXME : do 'real' use switching, add gucharmap support
# switches do not work by the looks of it

src_compile() {

	./autogen.sh

	econf `use_enable gnome` --with-sys-wv || die  

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

	# install plugins

	cd ${S_P}

	make DESTDIR=${D} install || die

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	newins ${WORKDIR}/${P}/abidistfiles/icons/abiword_48.png AbiWord.png
	insinto /usr/share/applications/
	doins ${FILESDIR}/AbiWord2.desktop

	dodoc COPYING *.TXT docs/build/BUILD.TXT abi/user/wp/readme.txt

}
