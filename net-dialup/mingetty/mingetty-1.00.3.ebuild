# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/mingetty/mingetty-1.00.3.ebuild,v 1.9 2004/01/06 15:36:14 agriffis Exp $

inherit rpm eutils

RHP=${PN}-1.00
S=${WORKDIR}/${RHP}
MYP=${PN}-1.00-3
DESCRIPTION="A compact getty program for virtual consoles only."
SRC_URI="http://distro.ibiblio.org/pub/Linux/distributions/redhat/8.0/en/os/i386/SRPMS/${MYP}.src.rpm
ftp://ftp.redhat.com/pub/redhat/linux/8.0/en/os/i386/SRPMS/${MYP}.src.rpm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc hppa amd64 alpha ~sparc ia64"

RDEPEND="virtual/glibc"

src_unpack() {
	rpm_src_unpack
	epatch ${FILESDIR}/mingetty-1.00-autologin.patch
}

src_compile() {
	emake RPM_OPTS="${CFLAGS}" || die
}

src_install () {
	into /
	dosbin mingetty
	doman mingetty.8
}
