# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Imaging/Imaging-1.1.2-r2.ebuild,v 1.17 2004/03/28 13:25:15 kloeri Exp $

IUSE="tcltk"

S=${WORKDIR}/${P}

DESCRIPTION="Python Imaging Library (PIL)."

SRC_URI="http://www.pythonware.net/storage/${P}.tar.gz"

HOMEPAGE="http://www.pythonware.com/downloads/#pil"

DEPEND=">=dev-lang/python-2.0
	>=media-libs/jpeg-6a
	>=sys-libs/zlib-0.95
	tcltk? ( dev-lang/tk )"


SLOT="0"
KEYWORDS="x86 sparc alpha ppc"
LICENSE="as-is"


src_compile() {

	#This is a goofy build.

	#Build the core imaging library (libImaging.a)
	cd ${S}/libImaging

	./configure --prefix=/usr \
		--host=${CHOST} || die
	cp Makefile Makefile.orig

	#Not configured by configure
	sed \
		-e "s:\(JPEGINCLUDE=[[:blank:]]*/usr/\)local/\(include\).*:\1\2:" \
		-e "s:\(OPT=[[:blank:]]*\).*:\1${CFLAGS}:" \
	Makefile.orig > Makefile

	emake || die

	#Build loadable python modules
	cd ${S}

	local scmd=""

	#First change all the "/usr/local" to "/usr"
	scmd="$scmd s:/usr/local:/usr:g;"

	# adjust for USE tcltk
	if use tcltk; then
		# Find the version of tcl/tk that has headers installed.
		# This will be the most recently merged, not necessarily the highest
		# version number.
		tclv=$(grep TCL_VER /usr/include/tcl.h | sed 's/^.*"\(.*\)".*/\1/')
		tkv=$( grep  TK_VER /usr/include/tk.h  | sed 's/^.*"\(.*\)".*/\1/')
		# adjust Setup to match
		scmd="$scmd s/-ltcl[0-9.]* -ltk[0-9.]*/-ltcl$tclv -ltk$tkv/;"
	else
		scmd="$scmd s:\(^_imagingtk\):#\1:;"
	fi

	sed "$scmd" Setup.in > Setup

	#No configure (#$%@!%%)
	scmd=""
	cp Makefile.pre.in Makefile.pre.in.orig
	#change all the "/usr/local" to "/usr" (haven't we been here before)
	scmd="$scmd s:/usr/local:/usr:g;"
	#fix man paths
	scmd="$scmd "'s:^\(MANDIR=.*/\)\(man\):\1share/\2:;'
	#Insert make.conf CFLAGS settings
	scmd="$scmd "'s:$(OPT)'":${CFLAGS}:;"

	sed "$scmd" Makefile.pre.in.orig > Makefile.pre.in

	#Now generate a top level Makefile
	make -f Makefile.pre.in boot || die

	emake || die

}

src_install () {

	#grab python verision so ebuild doesn't depend on it
	local pv
	pv=$(python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:')


	insinto /usr/lib/python$pv/site-packages
	doins PIL.pth

	insinto /usr/lib/python$pv/site-packages/PIL
	doins _imaging.so PIL/*
	use tcltk && doins _imagingtk.so

	# install headers required by media-gfx/sketch
	insinto /usr/include/python$pv
	doins libImaging/Imaging.h
	doins libImaging/ImPlatform.h
	doins libImaging/ImConfig.h

	dodoc CHANGES CONTENTS FORMATS README

}

