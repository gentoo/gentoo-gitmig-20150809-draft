# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hping/hping-2.0.0_rc2.ebuild,v 1.5 2003/09/05 23:40:09 msterret Exp $

# NOTE: author couldn't make up mind over tarball names, directory names,
# etc... hense the need to hardcode S and SRC_URI :(
S=${WORKDIR}/hping2-rc2
DESCRIPTION="hping is a command-line oriented TCP/IP packet assembler/analyzer whose interface is inspired by the unix ping command"
SRC_URI="http://www.hping.org/hping2.0.0-rc2.tar.gz"
HOMEPAGE="http://www.hping.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc hppa"

DEPEND="net-libs/libpcap"

src_compile() {
	./configure || die
	make CCOPT="$CFLAGS" || die
	make strip
}

src_install () {
	cd ${S}

	dodir /usr/sbin
	dosbin hping2
	dosym /usr/sbin/hping2 /usr/sbin/hping

	doman docs/hping2.8
	dodoc INSTALL KNOWN-BUGS MIRRORS NEWS README TODO AUTHORS BUGS CHANGES COPYING

}
