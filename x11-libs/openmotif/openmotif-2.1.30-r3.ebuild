# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/openmotif/openmotif-2.1.30-r3.ebuild,v 1.6 2003/12/16 12:33:16 gmsoft Exp $

inherit motif

MY_P=${P}-4_MLI.src
S=${WORKDIR}/motif
DESCRIPTION="Open Motif (Metrolink Bug Fix Release)"
SRC_URI="ftp://ftp.metrolink.com/pub/openmotif/2.1.30-4/${MY_P}.tar.gz"
HOMEPAGE="http://www.metrolink.com/openmotif/"
LICENSE="MOTIF"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

DEPEND="virtual/glibc
	virtual/x11"

SLOT="2.1"

# glibc-2.3.2-r1/gcc-3.2.3 /w `-mcpu=athlon-xp -O2', right-clicking
# in nedit triggers DPMS monitor standby instead of popping up the 
# context menu.  this doesn't happen on my `stable' test partition 
# where everything is compiled i686, nor with most non-essential 
# packages athlon-xp and only motif i686.  needs investigation.
inherit flag-o-matic
replace-flags "-mcpu=athlon-xp" "-mcpu=i686"

src_unpack() {
	local cfg="${S}/config/cf/site.def"

	unpack ${A}
	cd ${S}

	cp ${FILESDIR}/site.def ${S}/config/cf/
	echo >>$cfg
	echo >>$cfg "#undef  OptimizedCDebugFlags"
	echo >>$cfg "#define OptimizedCDebugFlags ${CFLAGS}"
	echo >>$cfg "#undef  OptimizedCplusplusDebugFlags"
	echo >>$cfg "#define OptimizedCplusplusDebugFlags ${CXXFLAGS}"

	# move `system.mwmrc' from `lib/X11' to `lib/X11/mwm' (but install into
	# `/etc/X11/mwm')
	ebegin "patching 'clients/mwm/Imakefile' (mwm confdir)"
	LC_ALL="C" sed -i \
	  -e 's:\(SpecialObjectRule.*WmResParse\.o.*/lib/X11\)\(.*\):\1/mwm\2:'\
	  -e 's:\(InstallNonExecFile.system\.mwmrc,\).*/lib/X11\(.*\):\1/etc/X11/mwm\2:'\
	    "${S}/clients/mwm/Imakefile"
	eend $? || die

	#
	epatch ${FILESDIR}/${P}-imake-tmpdir.patch
}

src_compile() {
	mkdir -p imports/x11
	cd imports/x11
	ln -s /usr/X11R6/bin bin
	ln -s /usr/X11R6/include include
	ln -s /usr/X11R6/lib lib
	cd ${S}
	make World || die
}

src_install() {
	make DESTDIR=${D} VARDIR=${D}/var/X11/ install || die "make install"
	make DESTDIR=${D} install.man || die "make install.man"

	# these overlap with X11
	local NOINSTBIN="imake lndir makedepend makeg mergelib mkdirhier xmkmf"
	local NOINSTMAN1="imake lndir makedepend makeg mkdirhier xmkmf"

	einfo "Cleaning up X11 stuff"
	rm -fR ${D}/etc
	for nib in $NOINSTBIN; do
		f="${D}usr/X11R6/bin/${nib}"; rm "$f" || die "rm $f"
	done
	for nim in $NOINSTMAN1; do
		f="${D}usr/X11R6/man/man1/${nim}.1x"; rm "$f" || die "rm $f"
	done
	rm -rf "${D}usr/X11R6/lib/X11/config" || die "rm config"


	einfo "Fixing includes"
	dodir /usr/include/Mrm/2.1/Mrm
	dodir /usr/include/Xm/2.1/Xm
	dodir /usr/include/uil/2.1/uil

	mv ${D}/usr/X11R6/include/Mrm/*.h ${D}/usr/include/Mrm/2.1/Mrm
	mv ${D}/usr/X11R6/include/Xm/*.h ${D}/usr/include/Xm/2.1/Xm
	mv ${D}/usr/X11R6/include/uil/*.h ${D}/usr/include/uil/2.1/uil


	einfo "Fixing binaries"
	dodir /usr/bin
	for file in `ls ${D}/usr/X11R6/bin`
	do
		mv ${D}/usr/X11R6/bin/${file} ${D}/usr/bin/${file}-2.1
	done


	einfo "Fixing libraries"
	dodir /usr/lib/motif/2.1
	mv ${D}/usr/X11R6/lib/lib* ${D}/usr/lib/motif/2.1

	for lib in libMrm.so.2 libMrm.so.2.1 \
		libXm.so.2 libXm.so.2.1 \
		libUil.so.2 libUil.so.2.1
	do
		dosym "/usr/lib/motif/2.1/${lib}"\
			"/usr/lib/${lib}"
	done
	dosym /usr/lib/motif/2.1/libMrm.so.2.1 /usr/lib/libMrm.so
	dosym /usr/lib/motif/2.1/libXm.so.2.1 /usr/lib/libXm.so
	dosym /usr/lib/motif/2.1/libUil.so.2.1 /usr/lib/libUil.so


	einfo "Fixing man pages"
	dodir /usr/share/man/man1
	dodir /usr/share/man/man3
	dodir /usr/share/man/man5
	dodir /usr/share/man/man7

	for file in `ls ${D}/usr/X11R6/man/man1`
	do
		file=${file/.1x/}
		mv ${D}/usr/X11R6/man/man1/${file}.1x ${D}/usr/share/man/man1/${file}-21.1
	done
	for file in `ls ${D}/usr/X11R6/man/man3`
	do
		file=${file/.3x/}
		mv ${D}/usr/X11R6/man/man3/${file}.3x ${D}/usr/share/man/man3/${file}-21.3
	done
	for file in `ls ${D}/usr/X11R6/man/man5`
	do
		file=${file/.5x/}
		mv ${D}/usr/X11R6/man/man5/${file}.5x ${D}/usr/share/man/man5/${file}-21.5
	done
	for file in `ls ${D}/usr/X11R6/man/man7`
	do
		file=${file/.7x/}
		mv ${D}/usr/X11R6/man/man7/${file}.7x ${D}/usr/share/man/man7/${file}-21.7
	done


	einfo "Cleaning up"
	rm -fR ${D}/usr/X11R6/


	einfo "Fixing docs"
	dodoc README COPYRIGHT.MOTIF RELEASE RELNOTES
	dodoc BUGREPORT OPENBUGS CLOSEDBUGS
}
