# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-0.9.3-r1.ebuild,v 1.1 2001/10/06 20:15:36 hallski Exp $

S=${WORKDIR}/${P}/abi
DESCRIPTION="Text processor"
SRC_URI="http://prdownloads.sourceforge.net/abiword/abiword-0.9.3.tar.gz"

HOMEPAGE="http://www.abisource.com"

DEPEND="virtual/glibc
	>=sys-devel/gcc-2.95.2
        =media-libs/freetype-1.3.1-r2
	>=media-libs/libpng-1.0.7
	>=x11-libs/gtk+-1.2.10-r4
        gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1
		 >=dev-libs/libunicode-0.4-r1
                 >=gnome-base/bonobo-1.0.9-r1
		 >=gnome-extra/gal-0.13-r1 )
        spell? ( >=app-text/pspell-0.11.2 )
	virtual/x11"


	if [ "`use gnome`" ] ; then
		myconf="ABI_OPT_GNOME=1 ABI_OPT_BONOBO=1 "
	fi

	if [ "`use spell`" ] ; then
		myconf="$myconf ABI_OPT_PSPELL=1"
	fi

src_compile() {
	if [ "`use spell`" ]
	then
		cd ${S}/src/config
		cp abi_defs.mk abi_defs.orig
		sed -e "s:-lltdl::" abi_defs.orig >  abi_defs.mk
	fi

	cd ${S}

	# Doesn't work with -j 4 (hallski)
	make prefix=/usr 						\
	     UNIX_CAN_BUILD_STATIC=0					\
	     $myconf							\
	     OPTIMIZER="$CFLAGS" || die
}

src_install() {
	make prefix=${D}/usr install || die

	cp ${D}/usr/AbiSuite/bin/AbiWord AbiWord.orig
	sed -e "s:${D}::" AbiWord.orig > ${D}/usr/AbiSuite/bin/AbiWord
	
	cd ${D}/usr/bin
	rm -f abiword
	rm -f AbiWord
	ln -s  ../AbiSuite/bin/AbiWord AbiWord
	ln -s  ../AbiSuite/bin/AbiWord abiword

	# Install icon and .desktop for menu entry
	if [ "`use gnome`" ] ; then
		insinto /usr/share/pixmaps
		newins ${WORKDIR}/${P}/abidistfiles/icons/abiword_48.png AbiWord.png
		insinto /usr/share/gnome/apps/Applications
		doins ${FILESDIR}/AbiWord.desktop
	fi
}

