# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/acpid/acpid-1.0.2-r2.ebuild,v 1.3 2004/01/29 02:45:49 agriffis Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Daemon for Advanced Configuration and Power Interface."
SRC_URI="mirror://sourceforge/acpid/${P}.tar.gz"
HOMEPAGE="http://acpid.sourceforge.net/"
IUSE=""
KEYWORDS="x86 ~amd64 -ppc alpha ia64"
SLOT="0"
LICENSE="GPL-2"

# We need the patched kernel with latest ACPI code, or else it will
# be broken.  Hopefully it will be merge into release kernel soon.
DEPEND="virtual/glibc
	virtual/linux-sources"

src_compile() {

	# Fix bug # 22238 (default.sh broken)
	( cd debian && epatch ${FILESDIR}/default.sh-gentoo.patch )

	# DO NOT COMPILE WITH OPTIMISATIONS.
	# That is a note to the devs.  IF you are a user, go ahead and optimise
	# if you want, but we won't support bugs associated with that"
	make INSTPREFIX=${D} || die
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

