# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/acpid/acpid-1.0.0.ebuild,v 1.5 2002/05/27 17:27:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Daemon for Advanced Configuration and Power Interface."
SRC_URI="mirror://sourceforge/acpid/${P}.tar.gz"
HOMEPAGE="http://acpid.sourceforge.net/"

# We need the patched kernel with latest ACPI code, or else it will
# be broken.  Hopefully it will be merge into release kernel soon.
DEPEND="virtual/glibc
	>=virtual/linux-sources-2.4.10-r4"


src_compile() {

	# DO NOT compile with optimizations !
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
