# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/clamav/clamav-0.60.ebuild,v 1.1 2003/06/22 09:58:51 prez Exp $

inherit eutils

DESCRIPTION="Clam Anti-Virus Scanner"
HOMEPAGE="http://clamav.elektrapro.com"
SRC_URI="http://clamav.elektrapro.com/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa"

DEPEND="virtual/glibc"
PROVIDE="virtual/antivirus"

pkg_setup() {
	enewgroup clamav
	enewuser clamav -1 /bin/false /dev/null clamav
	pwconv || die
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS NEWS README ChangeLog TODO FAQ INSTALL
	exeinto /etc/init.d ; newexe ${FILESDIR}/clamd.rc clamd
	insinto /etc/conf.d ; newins ${FILESDIR}/clamd.conf clamd
}
