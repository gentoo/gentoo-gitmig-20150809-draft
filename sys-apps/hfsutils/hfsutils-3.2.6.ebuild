# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Kain X <kain@kain.org>
# $Id: hfsutils-3.2.6.ebuild,v 1.1 2002/04/27 10:28:33 pvdabeel Exp $

# Source directory; the dir where the sources can be found
# (automatically unpacked) inside ${WORKDIR}.  Usually you can just
# leave this as-is.
S=${WORKDIR}/${P}

# Short one-line description of this package.
DESCRIPTION="HFS FS Access utils"

# Point to any required sources; these will be automatically
# downloaded by Portage.
SRC_URI="ftp://ftp.mars.org/pub/hfs/${P}.tar.gz"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://www.mars.org/home/rob/proj/hfs/"

# Build-time dependencies, such as
#    ssl? ( >=openssl-0.9.6b )
#    >=perl-5.6.1-r1
# It is advisable to use the >= syntax show above, to reflect what you
# had installed on your system when you tested the package.  Then
# other users hopefully won't be caught without the right version of
# a dependency.
DEPEND=""

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

MAKEOPTS='PREFIX=/usr MANDIR=/usr/share/man'

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/share/man
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
		
}
