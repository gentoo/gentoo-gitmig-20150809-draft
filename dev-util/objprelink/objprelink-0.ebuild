# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/objprelink/objprelink-0.ebuild,v 1.1 2001/08/21 23:23:17 danarmak Exp $

S=${WORKDIR}
SRC_URI="http://www.research.att.com/~leonb/objprelink/objprelink.c.gz"

HOMEPAGE="http://www.research.att.com/~leonb/objprelink/"
DESCRIPTION="Better startup times via smarter relocations. Used by qt&kde if USE objprelink is enabled."

DEPEND="sys-devel/gcc sys-devel/binutils"

src_unpack() {

	gzip -d < ${DISTDIR}/objprelink.c.gz > objprelink.c

}

src_compile() {
    
	gcc ${CFLAGS} -o objprelink objprelink.c /usr/lib/libbfd.a /usr/lib/libiberty.a

}

src_install () {

	into /usr
	dobin objprelink

}
