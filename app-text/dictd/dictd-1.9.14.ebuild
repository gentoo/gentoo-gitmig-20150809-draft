# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd/dictd-1.9.14.ebuild,v 1.6 2005/04/01 03:43:26 agriffis Exp $

inherit gnuconfig

DESCRIPTION="Dictionary Client/Server for the DICT protocol"
HOMEPAGE="http://www.dict.org/"
SRC_URI="mirror://sourceforge/dict/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~sparc ~alpha ~hppa ~mips ~amd64 ia64 ~ppc64"
IUSE=""

DEPEND="virtual/libc"

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
	doins ${FILESDIR}/1.9.11-r1/dict.conf
	doins ${FILESDIR}/1.9.11-r1/dictd.conf
	doins ${FILESDIR}/1.9.11-r1/site.info

	# startups for dictd
	exeinto /etc/init.d
	newexe ${FILESDIR}/1.9.11-r1/dictd dictd
	insinto /etc/conf.d
	newins ${FILESDIR}/1.9.11-r1/dictd.confd dictd
}
