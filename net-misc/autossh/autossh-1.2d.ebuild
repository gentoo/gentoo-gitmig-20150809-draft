# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/autossh/autossh-1.2d.ebuild,v 1.2 2003/04/14 15:58:36 weeve Exp $

S=${WORKDIR}/${P} 
DESCRIPTION="Automatically restart SSH sessions and tunnels" 
HOMEPAGE="http://www.harding.motd.ca/autossh/" 
LICENSE="BSD" 
KEYWORDS="~x86 ~sparc" 
SRC_URI="http://www.harding.motd.ca/autossh/${P}.tgz" 
SLOT="0" 
 
DEPEND="virtual/glibc 
	sys-apps/sed" 
RDEPEND="virtual/glibc 
	net-misc/openssh" 

src_unpack() { 
	unpack ${A} 
	cd ${S} 

	patch -p0 -l < ${FILESDIR}/${P}-reuse.patch 
	mv Makefile.linux Makefile.linux.orig 
	sed "s/CFLAGS=/CFLAGS=${CFLAGS}/g" Makefile.linux.orig >Makefile.linux 
} 
 
src_compile() { 
	emake -f Makefile.linux || die "make failed" 
} 
 
src_install() { 
	dobin autossh 
	dodoc CHANGES README autossh.host rscreen 
	doman autossh.1 
} 
 
