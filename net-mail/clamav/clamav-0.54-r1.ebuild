# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/clamav/clamav-0.54-r1.ebuild,v 1.4 2003/04/19 23:39:00 prez Exp $

DESCRIPTION="Clam Anti-Virus Scanner"
HOMEPAGE="http://clamav.elektrapro.com"
SRC_URI="http://clamav.elektrapro.com/stable/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~hppa ~sparc ~sparc64 ~ppc ~arm ~mips"
IUSE=""
PROVIDES="virtual/antivirus"
DEPEND="virtual/glibc"
S=${WORKDIR}/${P}

src_compile() {
	if ! grep -q ^clamav: /etc/group ; then
                groupadd clamav \
			|| die "problem adding the clamav group"
		grpconv || die "failed running grpconv"
        fi

	if ! grep -q ^clamav: /etc/passwd ; then
                useradd -g clamav clamav \
			|| die "problem adding the clamav user"
		pwconv || die "failed running pwconv"
        fi

	econf
	emake || die
}

src_install() {
	dodir /etc/init.d /etc/conf.d
	make DESTDIR=${D} install || die
	cp ${FILESDIR}/clamd.rc ${D}/etc/init.d
	cp ${FILESDIR}/clamd.conf ${D}/etc/conf.d
	dodoc AUTHORS BUGS NEWS README ChangeLog TODO FAQ INSTALL
}
