# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/acpid/acpid-1.0.1-r1.ebuild,v 1.6 2003/02/13 15:47:12 vapier Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Daemon for Advanced Configuration and Power Interface."
SRC_URI="mirror://sourceforge/acpid/${P}.tar.gz"
HOMEPAGE="http://acpid.sourceforge.net/"

KEYWORDS="x86 -ppc"
SLOT="0"
LICENSE="GPL-2"

# We need the patched kernel with latest ACPI code, or else it will
# be broken.  Hopefully it will be merge into release kernel soon.
DEPEND="virtual/glibc
	virtual/linux-sources"

src_compile() {
	make INSTPREFIX=${D} \
	CFLAGS="${CFLAGS} -DVERSION=\"\\\"${PV}\\\"\"" || die
}

src_install() {
	make INSTPREFIX=${D} install || die
	
	dodir /etc/acpi/events
	exeinto /etc/acpi
	doexe debian/default.sh
	insinto /etc/acpi/events
	doins debian/default
	
	dodoc README Changelog

	exeinto /etc/init.d
	newexe ${FILESDIR}/acpid.rc6 acpid
}

