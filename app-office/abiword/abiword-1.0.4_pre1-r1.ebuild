# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-1.0.4_pre1-r1.ebuild,v 1.5 2003/03/11 21:11:44 seemant Exp $

IUSE="perl nls gnome build spell jpeg xml2"

S=${WORKDIR}/${P}/abi
DESCRIPTION="Text processor"
SRC_URI="http://download.sourceforge.net/abiword/abiword-${PV}.tar.gz"
HOMEPAGE="http://www.abisource.com"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
DEPEND="virtual/x11
	media-libs/libpng
	>=dev-libs/libunicode-0.4-r1
	=x11-libs/gtk+-1.2*
	jpeg?  ( >=media-libs/jpeg-6b-r2 )
	xml2?  ( >=dev-libs/libxml2-2.4.10 )
	spell? ( >=app-text/aspell-0.50.2-r1 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1
		>=gnome-extra/gal-0.13-r1 
		>=gnome-base/bonobo-1.0.9-r1 )
	!app-shells/bash-completion"

# Disabled for now
#	perl?  ( >=dev-lang/perl-5.6 )

src_compile() {

	local myconf

	use gnome \
		&& myconf="${myconf} --with-gnome --enable-gnome" \
		&& export ABI_OPT_BONOBO=1

	myconf="${myconf} --disable-scripting"
#	use perl \
#		&& myconf="${myconf} --enable-scripting"
	
	use spell \
		&& myconf="${myconf} --with-pspell --disable-static"

	use xml2 \
		&& myconf="${myconf} --with-libxml2"

	use jpeg \
		&& myconf="${myconf} --with-libjpeg"
	
	use nls \
		&& myconf="${myconf} --enable-bidi"
	
	./autogen.sh
	
	einfo "Ignore above ERROR as it does not cause build to fail."

	CFLAGS="${CFLAGS} `gdk-pixbuf-config --cflags`"
	
	econf ${myconf}

	make || die
}

src_install() {

	dodir /usr/{bin,lib}

	einstall PERLDEST=${D}
	
	dosed "s:${D}::g" /usr/bin/AbiWord
	
	rm -f ${D}/usr/bin/abiword
	dosym /usr/bin/AbiWord /usr/bin/abiword

	dodoc BUILD COPYING *.txt, *.TXT

	# Install icon and .desktop for menu entry
	use gnome && ( \
		insinto /usr/share/pixmaps
		newins ${WORKDIR}/${P}/abidistfiles/icons/abiword_48.png AbiWord.png
		insinto /usr/share/gnome/apps/Applications
		doins ${FILESDIR}/AbiWord.desktop
	)
}
