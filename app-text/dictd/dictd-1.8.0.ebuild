# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd/dictd-1.8.0.ebuild,v 1.14 2004/04/07 21:43:54 vapier Exp $

inherit gnuconfig eutils

DESCRIPTION="Dictionary Client/Server for the DICT protocol"
HOMEPAGE="http://www.dict.org/"
SRC_URI="ftp://ftp.dict.org/pub/dict/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~alpha ~hppa ~mips ia64 ppc64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc33-multiline-string-fix.patch
}

src_compile() {
	# Update config.sub and config.guess so dictd understands the sparc architecture
	gnuconfig_update

	econf --with-etcdir=/etc/dict || die
	make || die
}

src_install() {
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
	dodoc README TODO ChangeLog ANNOUNCE
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
