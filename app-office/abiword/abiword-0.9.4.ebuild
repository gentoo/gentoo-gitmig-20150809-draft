# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>

S=${WORKDIR}/${P}/abi
DESCRIPTION="Text processor"
SRC_URI="http://prdownloads.sourceforge.net/abiword/abiword-${PV}.tar.gz"
HOMEPAGE="http://www.abisource.com"

DEPEND="virtual/glibc
	>=sys-devel/gcc-2.95.2
        =media-libs/freetype-1.3.1-r3
	>=media-libs/libpng-1.0.7
	>=x11-libs/gtk+-1.2.10-r4
        gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1
		 >=dev-libs/libunicode-0.4-r1
                 >=gnome-base/bonobo-1.0.9-r1
		 >=gnome-extra/gal-0.13-r1 )
        spell? ( >=app-text/pspell-0.11.2 )
	virtual/x11"


src_compile() {

	local myconf
	if [ "`use gnome`" ] ; then
		myconf="${myconf} --with-gnome"
		export ABI_OPT_BONOBO=1
	fi
	
	if [ "`use spell`" ] ; then
		myconf="${myconf} --with-pspell"
	fi

	./autogen.sh
	
	echo
	echo "*************************************************"
	echo "* Ignore above ERROR as it does not cause build *"
	echo "* to fail.                                      *"
	echo "*************************************************"
	echo

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info				\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    --enable-extra-optimization\			\
		    ${myconf} || die

	# Doesn't work with -j 4 (hallski)
	make UNIX_CAN_BUILD_STATIC=0					\
	     OPTIMIZER="${CFLAGS}" || die
}

src_install() {

	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	sed -e "s:${D}::" ${D}/usr/bin/AbiWord | cat> ${D}/usr/bin/AbiWord
	
	rm -f ${D}/usr/bin/abiword
	dosym /usr/bin/AbiWord /usr/bin/abiword

	dodoc BUILD COPYING *.txt, *.TXT

	# Install icon and .desktop for menu entry
	if [ "`use gnome`" ] ; then
		insinto /usr/share/pixmaps
		newins ${WORKDIR}/${P}/abidistfiles/icons/abiword_48.png AbiWord.png
		insinto /usr/share/gnome/apps/Applications
		doins ${FILESDIR}/AbiWord.desktop
	fi
}

