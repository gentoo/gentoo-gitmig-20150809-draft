# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-1.9.1.ebuild,v 1.1 2003/05/16 16:25:00 foser Exp $

inherit eutils debug

IUSE="spell jpeg xml2 gnome"

S=${WORKDIR}/${P}/abi
DESCRIPTION="Fully featured yet light and fast cross platform word processor."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.abisource.com"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"
LICENSE="GPL-2"
SLOT="2"

DEPEND="virtual/x11
	virtual/xft
	>=media-libs/fontconfig-2.1
	media-libs/libpng
	>=dev-libs/libunicode-0.4-r1
	>=dev-libs/libole2-0.2.4-r1
	>=x11-libs/gtk+-2
	>=app-text/wv-0.7.5
	>=dev-libs/fribidi-0.10.4
	jpeg?  ( >=media-libs/jpeg-6b-r2 )
	( xml2? >=dev-libs/libxml2-2.4.10 : dev-libs/expat )
	spell? ( >=app-text/aspell-0.50.3 )
	gnome? ( >=gnome-base/libgnomeui-2.2 
		>=gnome-base/libgnomeprintui-2.2.1 
		>=gnome-extra/gal-1.99 )"

#	perl?  ( >=dev-lang/perl-5.6 )
# perl seems broken

# FIXME : do 'real' use switching, add gucharmap support
# switches do not work by the looks of it

src_unpack() {
	unpack ${A}

	# Patch to make the wv.h tests work 
	# 
	# wv wants libole2 which in it's turn wants glib 1.2
	# glib.h includes glibconfig.h which is in a non-included path
	# and makes the tests fail, this patch adds those paths to configure.
	# Compiling without specifying the path anywhere goes fine.
	#
	# April 1st 2003 <foser@gentoo.org>
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.1.4-wv_configure_fooling.patch
}

src_compile() {
	local myconf

	use gnome \
		&& myconf="${myconf} --enable-gnome" \
		|| myconf="${myconf} --disable-gnome" 
		
	econf ${myconf} --with-sys-wv || die  

	emake all-recursive || die
}

src_install() {  
	dodir /usr/{bin,lib}
	
	einstall PERLDEST=${D} || die
	
	dosed "s:${D}::g" /usr/bin/AbiWord-2.0
	
	rm -f ${D}/usr/bin/abiword-2.0
	rm -f ${D}/usr/bin/abiword
	dosym AbiWord-2.0 /usr/bin/abiword-2.0

	dodoc COPYING *.TXT docs/build/BUILD.TXT

	# Install icon and .desktop for menu entry
	use gnome && ( \
		insinto /usr/share/pixmaps
		newins ${WORKDIR}/${P}/abidistfiles/icons/abiword_48.png AbiWord.png
		insinto /usr/share/applications/
		doins ${FILESDIR}/AbiWord2.desktop
		# Not installing oaf files, not overly stable.
	)
}

pkg_postinst() {
	einfo "For stability, install the latest 1.0.x release."
}

