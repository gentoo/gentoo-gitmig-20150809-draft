# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="Daemon for Advanced Configuration and Power Interface."
SRC_URI="http://prdownloads.sourceforge.net/acpid/${P}.tar.gz"
HOMEPAGE="http://acpid.sourceforge.net/"

DEPEND="virtual/glibc"


src_compile() {

	# DONT compile with optimizations !
	make INSTPREFIX=${D} ||die
}

src_install () {

	make INSTPREFIX=${D} install || die
	
	dodir /etc/acpi/events
	exeinto /etc/acpi
	doexe debian/default.sh
	insinto /etc/acpi/events
	doins debian/default
	
	dodoc README

	exeinto /etc/init.d
	newexe ${FILESDIR}/acpid.rc6 acpid
}
