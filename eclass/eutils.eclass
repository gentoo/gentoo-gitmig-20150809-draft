# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/eutils.eclass,v 1.1 2002/10/26 09:16:03 azarah Exp $
# This eclass is for general purpose functions that most ebuilds
# have to implement themselfs.
#
# NB:  If you add anything, please comment it!

ECLASS=eutils
INHERITED="$INHERITED $ECLASS"

newdepend sys-devel/patch

DESCRIPTION="Based on the ${ECLASS} eclass"

# This function generate linker scripts in /usr/lib for dynamic
# libs in /lib.  This is to fix linking problems when you have
# the .so in /lib, and the .a in /usr/lib.  What happens is that
# in some cases when linking dynamic, the .a in /usr/lib is used
# instead of the .so in /lib due to gcc/libtool tweaking ld's
# library search path.  This cause many builds to fail.
# See bug #4411 for more info.
#
# To use, simply call:
#
#   gen_usr_ldscript libfoo.so
#
# Note that you should in general use the unversioned name of
# the library, as ldconfig should usually update it correctly
# to point to the latest version of the library present.
#
# <azarah@gentoo.org> (26 Oct 2002)
#
gen_usr_ldscript() {

	# Just make sure it exists
	dodir /usr/lib
	
	cat > ${D}/usr/lib/$1 <<"END_LDSCRIPT"
/* GNU ld script
   Because Gentoo have critical dynamic libraries
   in /lib, and the static versions in /usr/lib, we
   need to have a "fake" dynamic lib in /usr/lib,
   otherwise we run into linking problems.
   See bug #4411 on http://bugs.gentoo.org/ for
   more info.  */
GROUP ( /lib/libxxx )
END_LDSCRIPT

	dosed "s:libxxx:$1:" /usr/lib/$1
}

