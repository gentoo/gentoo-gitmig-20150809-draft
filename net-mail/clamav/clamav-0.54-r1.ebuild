# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/clamav/clamav-0.54-r1.ebuild,v 1.8 2004/01/18 01:16:15 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Clam Anti-Virus Scanner"
HOMEPAGE="http://www.clamav.net/"
SRC_URI="http://prdownloads.sourceforge.net/clamav/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa"

DEPEND="virtual/glibc"
PROVIDE="virtual/antivirus"

pkg_setup() {
	enewgroup clamav
	enewuser clamav -1 /bin/false /dev/null clamav
	pwconv || die
}

src_compile() {
	has_version =sys-libs/glibc-2.2* && filter-flags -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS NEWS README ChangeLog TODO FAQ INSTALL
	exeinto /etc/init.d ; newexe ${FILESDIR}/clamd.rc clamd
	insinto /etc/conf.d ; newins ${FILESDIR}/clamd.conf clamd
}
