# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tod Neidt <tneidt@fidnet.com>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp
#Note: use with gnuplot-something.patch which is also in incoming, it will allow gnuplot to build against ploutils

S=${WORKDIR}/${P}

DESCRIPTION="a powerful C/C++ function library for exporting 2-D vector graphics"

SRC_URI="ftp://ftp.gnu.org/gnu/plotutils/${P}.tar.gz \
		X? ( ftp://ftp.hp.com/pub/printers/software/mp135mu.exe )"

HOMEPAGE="http://www.gnu.org/software/plotutils/"

DEPEND="virtual/glibc
		media-libs/libpng
		X? ( x11-base/xfree app-arch/unzip )"

src_unpack() {

	unpack ${P}.tar.gz
	if [ 'use X' ]
#Unpack the HP ps Type1 fonts
	then
		cd ${S}/fonts/pfb/
		cp ${DISTDIR}/mp135mu.exe ./
		unzip mp135mu.exe
	fi
	
}


src_compile() {
	
#enable build of C++ version
#disable libtool lock (can mess with parallel builds)
	local myconf="--enable-libplotter --disable-libtool-lock" 
	
#The following two additional configure options may be of interest
#to users with specific printers, i.e. HP LaserJets with PCL 5 or HP-GL/2.
#Not sure if enabling screws the pooch for those without these printers.
#--enable-ps-fonts-in-pcl --enable-lj-fonts-in-ps
	
	if [ -z 'use X' ]
	then
		myconf="${myconf} --without-x"
#enable stand alone X rasterization lib and laserjet fonts in X
	else
		myconf="${myconf} --with-x --enable-libxmi --enable-lj-fonts-in-x"
 	fi
 
	./configure --infodir=/usr/share/info \
				--mandir=/usr/share/man \
				--prefix=/usr \
				--host=${CHOST} \
				${myconf} || die
	
	emake || die

}

src_install () {

	make prefix=${D}/usr install || die
	
	if [ 'use X' ]
	then
		local type1_dir=/usr/X11R6/lib/X11/fonts/Type1
		local misc_dir=/usr/X11R6/lib/X11/fonts/misc
		
		cd ${S}/fonts

#Add extra Type1 fonts
#This will probably break if portage becomes sandboxed
		cp ${type1_dir}/fonts.scale ./

#Determine the number of existing Type1 fonts	
		local n0=$( sed -e '1!d' fonts.scale )
		
#Determine the number of fonts to add
		local n1=$( ls pfb/*.pfb | wc -w )
		
		let "n1 = $n1 + $n0"
		
		cat fonts.append >> fonts.scale
		
#Adjust number of Type1 fonts to new number
		sed -e 's/'$n0'$/'$n1'/' fonts.scale > fonts.scale.new
		mv fonts.scale.new fonts.scale		
	
		insinto ${type1_dir}
		doins pfb/*.pfb fonts.scale
		
#Finally, store a copy of the modified xfig source file u_fonts.c
#so users can recompile xfig to use the new fonts
		insinto /usr/share/${PN}
		doins u_fonts.c

#Add extra misc Tektronix bitmapped fonts
#all the misc fonts seem to be gzipped
		gzip pcf/*.pcf
		insinto ${misc_dir}
		doins pcf/*.pcf.gz
	
	fi

	cd ${S}
	dodoc AUTHORS COMPAT COPYING ChangeLog INSTALL INSTALL.fonts INSTALL.pkg \
			KNOWN_BUGS NEWS ONEWS PROBLEMS README THANKS TODO
	
}

pkg_postinst() {

	if [ 'use X' ]
	then
#enable new Type1 fonts and have X server 
		cd /usr/X11R6/lib/X11/fonts/Type1
		mkfontdir
#enable new Tektronix fonts	
		cd /usr/X11R6/lib/X11/fonts/misc
		mkfontdir
#Check if X server is running. If yes, rescan the fonts
		if [ -f /tmp/.X*-lock ]
		then
			xset fp rehash
		fi

		echo ""
		echo "*********************************************************"	
		echo "If you use the program xfig, you might want to recompile"
		echo "to take advantage of the additional ps fonts."
		echo "Also, it is possible to enable ghostscript and possibly"
		echo "your printer to use the HP fonts, but you are on your own." 
		echo "See /user/share/doc/${P}/INSTALL.fonts"
		echo "**********************************************************"
		echo ""

	fi

}