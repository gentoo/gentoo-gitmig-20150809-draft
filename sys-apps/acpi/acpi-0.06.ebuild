# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/acpi/acpi-0.06.ebuild,v 1.4 2004/02/23 00:37:07 agriffis Exp $

DESCRIPTION="Attempts to replicate the functionality of the 'old' apm command on ACPI systems, including battery and thermal information."
HOMEPAGE="http://packages.debian.org/unstable/utils/acpi.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-alpha -hppa -mips -sparc x86"
IUSE=""
DEPEND="virtual/glibc"
S=${WORKDIR}/${PN}

src_compile() {
	econf || die
	emake || die
	( cd doc && make ) || die
}

src_install() {
	einstall || die
	( cd doc && doman acpi.1 )
	dodoc AUTHORS CREDITS ChangeLog README
}
