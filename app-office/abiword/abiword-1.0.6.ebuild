# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-1.0.6.ebuild,v 1.1 2003/06/01 06:34:06 lostlogic Exp $

inherit flag-o-matic

replace-flags "-O?" "-O1"
IUSE="nls build spell jpeg xml2"

S=${WORKDIR}/${P}/abi

DESCRIPTION="Word processor"
SRC_URI="mirror://sourceforge/abiword/${P}.tar.gz"
HOMEPAGE="http://www.abisource.com"

KEYWORDS="~x86 ~ppc ~sparc"
LICENSE="GPL-2"
SLOT="1"

DEPEND="virtual/x11
	media-libs/libpng
	>=dev-libs/libunicode-0.4-r1
	=x11-libs/gtk+-1.2*
	jpeg?  ( >=media-libs/jpeg-6b-r2 )
	xml2?  ( >=dev-libs/libxml2-2.4.10 )
	spell? ( >=app-text/aspell-0.50.2-r1 )
	!app-shells/bash-completion"

# gnome build seems broken <foser@gentoo.org>
#	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1
#		>=gnome-extra/gal-0.13-r1 
#		>=gnome-base/bonobo-1.0.9-r1 )

src_compile() {
	local myconf

#	use gnome \
#		&& myconf="${myconf} --with-gnome --enable-gnome"; \
#		export ABI_OPT_BONOBO=1

	use spell \
		&& myconf="${myconf} --with-pspell --disable-static"

	use xml2 \
		&& myconf="${myconf} --with-libxml2" \
		|| myconf="${myconf} --without-libxml2"
	use jpeg \
		&& myconf="${myconf} --with-libjpeg" \
		|| myconf="${myconf} --without-libjpeg"
	
	use nls \
		&& myconf="${myconf} --enable-bidi"
	
	./autogen.sh
	
	einfo "Ignore above ERROR as it does not cause build to fail."

	CFLAGS="${CFLAGS} `gdk-pixbuf-config --cflags`"
	
	# we got enough of the perl problems for now
	econf ${myconf} --disable-scripting

	make || die
}

src_install() {
	dodir /usr/{bin,lib}

	einstall
	
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
