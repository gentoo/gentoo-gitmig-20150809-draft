# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# /home/cvsroot/gentoo-x86/skel.build,v 1.3 2001/07/05 02:43:36 drobbins Exp

# !! IMPORTANT NOTE !!
# The Xaw3d widget set is meant to be built as part of the X Consortium's
# official R6.x tree. Building it against XFree86 creates a problem,
# hence Xaw3d-xfree86.diff. Building it out-of-tree (i.e. without the
# entire X source present) creates another problem because, like X,
# Xaw3d uses Imakefiles which fit into the X hierarchy. Hence Xaw3d-out-of-tree.diff
# (The problem it takes care of is a missing widec.h)
# This implementation of the build process, together with the 2 patches,
# comes from Slackware with very slight modifications introduced. If you
# want to see the original, go to ftp.slackware.com and into the source - 
# it has standard shell scripts in text files for compiling.
# Another (similar) set of instructions can be found at the gv homepage:
# http://wwwthep.physik.uni-mainz.de/~plass/gv/Xaw3d.html
#
# NOTE: I did not write these patches. I did rename them, and have a lurking
# suspicion I confused them and switched the names arond. Someone who is
# better versed in compiling X and the structure of its Imakefiles might
# want to take a look at it. But it does work :-)

S=${WORKDIR}/xc/lib/Xaw3d

DESCRIPTION="the Xaw3d is a drop-in 3D replacement of the Xaw widget set
	     which comes with X. It is used e.g. by gv the ghostcript frontend."

# All full ftp.x.org mirrors can be added here.
SRC_URI="ftp://ftp.x.org/contrib/widgets/Xaw3d/R6.3/${P}.tar.gz
	 http://ibiblio.org/pub/X11/contrib/widgets/Xaw3d/R6.3/${P}.tar.gz"

# None so far as I know.
#HOMEPAGE="http://"

# There _might_ be something else, but I doubt it.
DEPEND="virtual/x11"

src_unpack() {
    
    unpack ${P}.tar.gz
    cd ${S}
    
    # For some reason it isn't automatically patched.
    # That's why I manually override the source_unpack function.
    patch -p0 <${FILESDIR}/Xaw3d-xfree86.diff
    patch -p0 <${FILESDIR}/Xaw3d-out-of-tree.diff
    
}

src_compile() {
    
    # convoluted process for out-of-tree building
    mkdir ./X11
    cd ./X11 ; ln -sf ../../Xaw3d . ; cd ..
    
    try xmkmf
    try emake
    
}

src_install () {
    
    # There is no install target in the Makefile.
    # We have to copy everything by hand.
    # Update: usage of ebuild installation functions added by achim, thanks
    
    into /usr/X11R6
    dolib.so libXaw3d.so.[0-9].[0-9]
    preplib /usr/X11R6

    # headers
    insinto /usr/X11R6/include/X11/Xaw3d
    doins *.h

    dodoc README.XAW3D
}

