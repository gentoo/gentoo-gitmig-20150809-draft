# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/c.eclass,v 1.1 2001/09/28 19:25:33 danarmak Exp $
# The "c" eclass merely adds gcc, glibc and ld.so to DEPEND/RDEPEND for comfort.
. /usr/portage/inherit.eclass || die
inherit virtual || die
ECLASS=c

S=${WORKDIR}/${P}
DESCRIPTION="Based on the $ECLASS eclass"
DEPEND="${DEPEND} sys-devel/gcc virtual/glibc sys-devel/ld.so"
RDEPEND="${RDEPEND} sys-devel/gcc virtual/glibc sys-devel/ld.so"

