# Copyright 2000-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Peter Kadau <peter.kadau@web.de>
# $HEADER$

A=cdrdao-1.1.5.src.tar.gz
S=${WORKDIR}/cdrdao-1.1.5
DESCRIPTION="Burn CDs in disk-at-once mode"
SRC_URI="http://prdownloads.sourceforge.net/cdrdao/${A}"
HOMEPAGE="http://cdrdao.sourceforge.net/"

DEPEND=">=dev-util/pccts-1.33.24-r1"
RDEPEND=""

src_unpack() {
	unpack ${A}
	# remove xdao subdir
	rm -rf cdrdao-1.1.5/xdao 
	# truncate configure and Makefile.in, so they won't
	# miss xdao anymore
	# configure leaves out all the gtk-related stuff
	patch -p0 <${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	try ./configure --prefix=/usr --build="${CHOST}" \
	   --host="${CHOST}"

	try emake
}

src_install() {
	# binary
	# cdrdao in /usr/bin
	dobin dao/cdrdao
	# data of cdrdao in /usr/share/cdrdao/
	# (right now only driverlist)
	insinto /usr/share/cdrdao
	newins dao/cdrdao.drivers drivers
	# man page
	# cdrdao.1 in /usr/share/man/man1/
	into /usr
	newman dao/cdrdao.man cdrdao.1
	# documentation
	docinto ""
	dodoc COPYING CREDITS INSTALL README* Release*
}
