# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/clamav/clamav-0.54.ebuild,v 1.1 2003/02/03 08:21:07 raker Exp $

DESCRIPTION="Clam Anti-Virus Scanner"
HOMEPAGE="http://clamav.elektrapro.com"
SRC_URI="http://clamav.elektrapro.com/stable/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/glibc"
S=${WORKDIR}/${P}

src_compile() {
	if ! grep -q ^clamav: /etc/passwd; then
		einfo ""
		einfo "Please add the clamav user and group before emerging"
		einfo ""
		einfo "groupadd clamav"
		einfo "useradd -g clamav -s /bin/false -c \"Clam AntiVirus\" clamav"
		einfo ""
		die
	fi
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS NEWS README ChangeLog TODO FAQ INSTALL
}
