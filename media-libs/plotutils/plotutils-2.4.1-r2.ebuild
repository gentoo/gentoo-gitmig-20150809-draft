# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

#The plotutils package contains extra X fonts.  These fonts are not installed
#in the current ebuild.  The commented out ebuild lines below are for future 
#reference when this ebuild may be updated to install the fonts.
#NOTE: The current method does not play nice with X and sandbox.  Most of the
#font installation procedures should probably be moved to pkg_postinst.
#See Bug# 30 at http://bugs.gentoo.org/show_bug.cgi?id=30

S=${WORKDIR}/${P}

DESCRIPTION="a powerful C/C++ function library for exporting 2-D vector graphics"

SRC_URI="ftp://ftp.gnu.org/gnu/plotutils/${P}.tar.gz"
#	X? ( ftp://ftp.hp.com/pub/printers/software/mp135mu.exe )

HOMEPAGE="http://www.gnu.org/software/plotutils/"

DEPEND="virtual/glibc
	media-libs/libpng
	X? ( virtual/x11 )"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/plotutils-2.4.1-gentoo.patch || die

}

src_compile() {
	
#enable build of C++ version
	local myconf="--enable-libplotter" 
	
#The following two additional configure options may be of interest
#to users with specific printers, i.e. HP LaserJets with PCL 5 or HP-GL/2.
#Not sure if enabling screws the pooch for those without these printers.
#--enable-ps-fonts-in-pcl --enable-lj-fonts-in-ps
	
	use X	\
		&& myconf="${myconf} --with-x --enable-libxmi"	\
		|| myconf="${myconf} --without-x"
 
	./configure --infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--host=${CHOST} \
		${myconf} || die "./configure failed"
	
	emake || die "Parallel Make Failed"

}

src_install () {

	make prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die "Installation Failed"
	
	dodoc AUTHORS COMPAT COPYING ChangeLog INSTALL INSTALL.fonts INSTALL.pkg \
			KNOWN_BUGS NEWS ONEWS PROBLEMS README THANKS TODO
	
}

pkg_postinst() {

	if [ 'use X' ]
	then
		einfo ""
		einfo "*********************************************************"	
		einfo ""
		einfo "There are extra fonts available in plotutils package."
		einfo "The current ebuild does not install them for you."
		einfo "You may want to do so, but you will have to do it"
		einfo "manually. You are on your own for now."
		einfo "See /usr/share/doc/${P}/INSTALL.fonts"
		einfo ""
		einfo "If you manually install the extra fonts and use the"
		einfo "program xfig, you might want to recompile to take"
		einfo "advantage of the additional ps fonts."
		einfo "Also, it is possible to enable ghostscript and possibly"
		einfo "your printer to use the HP fonts." 
		einfo ""
		einfo "**********************************************************"
		einfo ""

	fi

}
