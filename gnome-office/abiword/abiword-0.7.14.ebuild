# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-office/abiword/abiword-0.7.14.ebuild,v 1.5 2001/09/30 12:20:39 azarah Exp $

A="abi-${PV}.tar.gz abidistfiles-${PV}.tar.gz expat-${PV}.tar.gz psiconv-${PV}.tar.gz
   unixfonts-${PV}.tar.gz wv-${PV}.tar.gz"
S=${WORKDIR}/abi
DESCRIPTION="Framework for creating database applications"
SRC_URI="http://www.abisource.com/downloads/Version-${PV}/abi-${PV}.tar.gz
	 http://www.abisource.com/downloads/Version-${PV}/abidistfiles-${PV}.tar.gz
	 http://www.abisource.com/downloads/Version-${PV}/expat-${PV}.tar.gz
	 http://www.abisource.com/downloads/Version-${PV}/psiconv-${PV}.tar.gz
	 http://www.abisource.com/downloads/Version-${PV}/unixfonts-${PV}.tar.gz
	 http://www.abisource.com/downloads/Version-${PV}/wv-${PV}.tar.gz"


HOMEPAGE="http://www.gnome.org/gnome-office/abiword.shtml/"

DEPEND="virtual/glibc
	>=sys-devel/gcc-2.95.2
        =media-libs/freetype-1.3.1-r2
	>=media-libs/libpng-1.0.7
	>=x11-libs/gtk+-1.2.8
        gnome? ( >=gnome-base/gnome-libs-1.2.10 >=gnome-base/libunicode-0.4
                 >=gnome-base/bonobo-1.0.4 >=gnome-base/gal-0.8 )
        spell? ( app-text/pspell-0.11.2 )
	virtual/x11"


  if [ "`use gnome`" ] ; then
    myconf="ABI_OPT_GNOME=1 ABI_OPT_BONOBO=1 "
  fi
  if [ "`use spell`" ] ; then
    myconf="$myconf ABI_OPT_PSPELL=1"
  fi

src_compile() {
  if [ "`use spell`" ] ; then
    cd ${S}/src/config
    cp abi_defs.mk abi_defs.orig
    sed -e "s:-lltdl::" abi_defs.orig >  abi_defs.mk
  fi
  cd ${S}

  # Doesn't work with -j 4 (hallski)
  try make prefix=/opt/gnome/ UNIX_CAN_BUILD_STATIC=0 $myconf OPTIMIZER="$CFLAGS"

}

src_install() {
	#do you really need the OPTIMIZER var below? -- DR
  try make prefix=${D}/opt/gnome  UNIX_CAN_BUILD_STATIC=0 $myconf OPTIMIZER="$CFLAGS" install
  cp ${D}/opt/gnome/AbiSuite/bin/AbiWord AbiWord.orig
  sed -e "s:${D}::" AbiWord.orig > ${D}/opt/gnome/AbiSuite/bin/AbiWord
  cd ${D}/opt/gnome/bin
  rm -f abiword
  rm -f AbiWord
  ln -s  ../AbiSuite/bin/AbiWord AbiWord
  ln -s  ../AbiSuite/bin/AbiWord abiword
  
  # Install icon and .desktop for menu entry (hopefully this works for this version,
  # as I have only tested it for 0.9.3
  if [ "`use gnome`" ] ; then
            insinto ${GNOME_PATH}/share/pixmaps
            newins ${WORKDIR}/${P}/abidistfiles/icons/abiword_48.png AbiWord.png
            insinto ${GNOME_PATH}/share/gnome/apps/Applications
            doins ${FILESDIR}/AbiWord.desktop
  fi
  
}




