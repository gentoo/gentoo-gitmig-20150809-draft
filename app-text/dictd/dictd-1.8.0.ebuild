# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd/dictd-1.8.0.ebuild,v 1.10 2003/12/17 03:44:28 brad_mssw Exp $

inherit gnuconfig

DESCRIPTION="Dictionary Client/Server for the DICT protocol"
HOMEPAGE="http://www.dict.org/"
SRC_URI="ftp://ftp.dict.org/pub/dict/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ia64 ppc64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	# Patch to fix a gcc-3.3.x multi-line string issue.
	# Closes Bug #29227
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
