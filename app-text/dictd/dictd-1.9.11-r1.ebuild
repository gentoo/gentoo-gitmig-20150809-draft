# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd/dictd-1.9.11-r1.ebuild,v 1.1 2004/02/09 07:13:59 absinthe Exp $

inherit gnuconfig

DESCRIPTION="Dictionary Client/Server for the DICT protocol"
HOMEPAGE="http://www.dict.org/"
SRC_URI="mirror://sourceforge/dict/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm amd64 ~ia64 ~ppc64"

DEPEND="virtual/glibc"

src_compile() {

	# Update config.sub and config.guess so dictd understands the sparc architecture
	gnuconfig_update

	econf \
		--with-cflags="${CFLAGS}" \
		--sysconfdir=/etc/dict || die
	make || die
}

src_install() {
	# Now install it.
	make DESTDIR=${D} install || die "install failed"

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
