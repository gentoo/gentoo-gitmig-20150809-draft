# Copyright 1999-2001 Gentoo Technologies, Inc.
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
#	X? ( virtual/x11 app-arch/unzip )"

#src_unpack() {

#	unpack ${P}.tar.gz
#	if [ 'use X' ]
#Unpack the HP ps Type1 fonts
#	then
#		cd ${S}/fonts/pfb/
#		cp ${DISTDIR}/mp135mu.exe ./
#		unzip mp135mu.exe
#	fi
#	
#}


src_compile() {
	
#enable build of C++ version
	local myconf="--enable-libplotter" 
	
#The following two additional configure options may be of interest
#to users with specific printers, i.e. HP LaserJets with PCL 5 or HP-GL/2.
#Not sure if enabling screws the pooch for those without these printers.
#--enable-ps-fonts-in-pcl --enable-lj-fonts-in-ps
	
	if [ -z 'use X' ]
	then
		myconf="${myconf} --without-x"
#enable stand alone X rasterization lib and laserjet fonts in X
	else
		myconf="${myconf} --with-x --enable-libxmi"
#		myconf="${myconf} --with-x --enable-libxmi --enable-lj-fonts-in-x"
	fi
 
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
	
#	if [ 'use X' ]
#	then
#		local type1_dir=/usr/X11R6/lib/X11/fonts/Type1
#		local misc_dir=/usr/X11R6/lib/X11/fonts/misc
#		
#		cd ${S}/fonts
#
#Add extra Type1 fonts
#This will probably break if portage becomes sandboxed
#		cp ${type1_dir}/fonts.scale ./
#
#Determine the number of existing Type1 fonts	
#		local n0=$( sed -e '1!d' fonts.scale )
#		
#Determine the number of fonts to add
#		local n1=$( ls pfb/*.pfb | wc -w )
#		
#		let "n1 = $n1 + $n0"
#		
#		cat fonts.append >> fonts.scale
#		
#Adjust number of Type1 fonts to new number
#		sed -e 's/'$n0'$/'$n1'/' fonts.scale > fonts.scale.new
#		mv fonts.scale.new fonts.scale		
#	
#		insinto ${type1_dir}
#		doins pfb/*.pfb fonts.scale
#		
#Finally, store a copy of the modified xfig source file u_fonts.c
#so users can recompile xfig to use the new fonts
#		insinto /usr/share/${PN}
#		doins u_fonts.c
#
#Add extra misc Tektronix bitmapped fonts
#all the misc fonts seem to be gzipped
#		gzip pcf/*.pcf
#		insinto ${misc_dir}
#		doins pcf/*.pcf.gz
#	
#	fi

#	cd ${S}
	dodoc AUTHORS COMPAT COPYING ChangeLog INSTALL INSTALL.fonts INSTALL.pkg \
			KNOWN_BUGS NEWS ONEWS PROBLEMS README THANKS TODO
	
}

pkg_postinst() {

	if [ 'use X' ]
	then
#enable new Type1 fonts and have X server 
#		cd /usr/X11R6/lib/X11/fonts/Type1
#		mkfontdir
#enable new Tektronix fonts	
#		cd /usr/X11R6/lib/X11/fonts/misc
#		mkfontdir
#Check if X server is running. If yes, rescan the fonts
#		if [ -f /tmp/.X*-lock ]
#		then
#			xset fp rehash
#		fi

		einfo ""
		einfo "*********************************************************"	
		einfo ""
		einfo "There are extra fonts available in plotutils package."
		einfo "The current ebuild does not install them for you."
		einfo "You may want to do so, but you will have to do it"
		einfo "manually. You are on your own for now."
		einfo "See /user/share/doc/${P}/INSTALL.fonts"
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
