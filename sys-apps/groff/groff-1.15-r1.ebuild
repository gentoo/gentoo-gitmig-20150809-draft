# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/groff/groff-1.15-r1.ebuild,v 1.2 2000/08/16 04:38:26 drobbins Exp $

P=groff-1.15
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Text formatter used for man pages"
SRC_URI="ftp://prep.ai.mit.edu/gnu/groff/${A}"
HOMEPAGE="http://www.gnu.org/software/groff/groff.html"

src_compile() {
	./configure --host=${CHOST} --prefix=/usr
	cd ${S}/tmac
	mv Makefile.sub Makefile.sub.orig
	sed -e "s/all: stamp-strip stamp-wrap/all: stamp-strip/" Makefile.sub.orig > Makefile.sub
	#fixed some things with the build process using good 'ol sed
	cd ${S}
	make
}

src_install() {                               
	into /usr
	dodoc NEWS PROBLEMS PROJECTS README TODO VERSION BUG-REPORT COPYING ChangeLog
	for x in addftinfo afmtodit eqn grodvi groff grog grolj4 grops grotty hpftodit indxbib lkbib nroff pfbtops pic psbb refer soelim tbl tfmtodit troff
	do
	    cd ${S}/$x
	    dobin $x
	    cp $x.man $x.1
	    doman $x.1
	done
	cd ${S}
	dobin eqn/neqn
	dosym tbl /usr/bin/gtbl
	dosym eqn /usr/bin/geqn
	cd ${S}/man
	cp groff_char.man groff_char.7
	cp groff_font.man groff_font.5
	cp groff_out.man groff_out.5
	doman *.[1-9]
	cd ${S}/tmac
	cp groff_ms.man groff_ms.7
	doman *.[1-9]
	cd ${S}/mm
	cp groff_mm.man groff_mm.7
	cp groff_mmse.man groff_mmse.7
	doman *.[1-9]
	cd ${S}
	insinto /usr/share/groff
	doins indxbib/eign
	cd ${S}/devX100
	insinto /usr/share/groff/font/devX100
	doins CB CBI CI CR DESC HB HBI HI HR NB NBI NI NR S TB TBI TI TR
	cd ${S}/devX75
	insinto /usr/share/groff/font/devX75
	doins CB CBI CI CR DESC HB HBI HI HR NB NBI NI NR S TB TBI TI TR
	cd ${S}/devX75-12
	insinto /usr/share/groff/font/devX75-12
	doins CB CBI CI CR DESC HB HBI HI HR NB NBI NI NR S TB TBI TI TR
	cd ${S}/devascii
	insinto /usr/share/groff/font/devascii
	doins B BI DESC I R
	cd ${S}/devdvi
	insinto /usr/share/groff/font/devdvi
	doins B BI CW DESC EX H HB HI I MI R S SA SB
	insinto /usr/share/groff/font/devdvi/generate
	doins generate/*
	cd ${S}/devlatin1
	insinto /usr/share/groff/font/devlatin1
	doins B BI DESC I R
	cd ${S}/devlj4
	insinto /usr/share/groff/font/devlj4
	doins ALBB ALBR AOB AOI AOR CB CBI CI CLARENDON CORONET CR DESC GB GBI GI GR LGB LGI LGR MARIGOLD OB OBI OI OR S TB TBI TI TR UB UBI UCB UCBI UCI UCR UI UR
	insinto /usr/share/groff/font/devlj4/generate
	doins generate/Makefile generate/special.map generate/text.map
	cd ${S}/devps
	insinto /usr/share/groff/font/devps
	doins AB ABI AI AR BMB BMBI BMI BMR CB CBI CI CR DESC HB HBI HI HNB HNBI HNI HNR HR NB NBI NI NR PB PBI PI PR S SS TB TBI TI TR ZCMI ZD ZDR download prologue symbolsl.pfa text.enc zapfdr.pfa
	insinto /usr/share/groff/font/devps/generate
	doins generate/*
	cd ${S}/tmac
	insinto /usr/share/groff/tmac
	doins eqnrc man.local tmac.* troffrc
	doins ${S}/troff/hyphen.us
	cd ${S}/mm/mm
	insinto /usr/share/groff/tmac/mm
	doins *
	insinto /usr/share/groff/tmac/mdoc
	cd ${S}/tmac
	doins doc-*
}


