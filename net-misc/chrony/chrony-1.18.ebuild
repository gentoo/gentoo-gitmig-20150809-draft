# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/chrony/chrony-1.18.ebuild,v 1.5 2002/08/14 12:08:07 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="NTP client and server programs"
SRC_URI="http://chrony.sunsite.dk/download/${P}.tar.gz"
HOMEPAGE="http://chrony.sunsite.dk"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc
		readline? ( >=readline-4.1-r4 )"
RDEPEND=$DEPEND

# Patch the distribution so that it puts stuff in /etc/chrony/ by default
src_unpack() {
	unpack ${A}
	cd ${S}
	cp conf.c conf.c.orig
	patch -p0 < ${FILESDIR}/${P}-conf.c-gentoo.diff
	cd examples
	cp chrony.conf.example chrony.conf.example.orig
	patch -p0 < ${FILESDIR}/${P}-chrony.conf.example-gentoo.diff
}

src_compile() {

	local myconf

	use readline || myconf="--disable-readline"

	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		$myconf || die "./configure failed"
		
	emake all docs || die
}

src_install () {
	# the chrony install is brain-dead so we'll
	# just do it ourselves.

	dobin chronyc
	dosbin chronyd
	
	# documentation
	dodoc chrony.txt chrony.html COPYING README

	# man pages
	doman *.{1,5,8}	

	# info files
	doinfo chrony.info*

	# example configuration files
	dodoc examples/chrony.conf.example
	dodoc examples/chrony.keys.example

	# system configuration
	exeinto /etc/init.d ; newexe ${FILESDIR}/chronyd.rc chronyd
	dodir /etc/chrony
}
