# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd/dictd-1.8.0.ebuild,v 1.6 2003/09/05 22:37:21 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Dictionary Client/Server for the DICT protocol"
SRC_URI="ftp://ftp.dict.org/pub/dict/${P}.tar.gz"
HOMEPAGE="http://www.dict.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc"

DEPEND="virtual/glibc"

src_compile() {

	econf \
		--with-etcdir=/etc/dict
	make || die
}

src_install () {
	# gotta set up the dirs for it....
	dodir /usr/bin
	dodir /usr/sbin
	dodir /usr/share/man/man1
	dodir /usr/share/man/man8

	# Now install it.
	make \
		prefix=${D}/usr \
		man1_prefix=${D}/usr/share/man/man1 \
		man8_prefix=${D}/usr/share/man/man8 \
		conf=${D}/etc/dict \
		install || die

	# Install docs
	dodoc README TODO COPYING ChangeLog ANNOUNCE
	dodoc doc/dicf.ms doc/rfc.ms doc/rfc.sh doc/rfc2229.txt
	dodoc doc/security.doc doc/toc.ms

	# conf files.
	dodir /etc/dict
	insinto /etc/dict
	doins ${FILESDIR}/${PVR}/dict.conf
	doins ${FILESDIR}/${PVR}/dictd.conf
	doins ${FILESDIR}/${PVR}/site.info

	# startups for dictd
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PVR}/dictd dictd
	insinto /etc/conf.d
	newins ${FILESDIR}/${PVR}/dictd.confd dictd
}
