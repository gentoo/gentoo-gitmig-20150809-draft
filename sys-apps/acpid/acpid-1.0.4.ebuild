# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/acpid/acpid-1.0.4.ebuild,v 1.1 2004/10/19 08:07:45 brix Exp $

DESCRIPTION="Daemon for Advanced Configuration and Power Interface"
HOMEPAGE="http://acpid.sourceforge.net"
SRC_URI="mirror://sourceforge/acpid/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -ppc ~alpha ~amd64 ~ia64"
IUSE="doc"

DEPEND="virtual/libc
		virtual/linux-sources"

src_compile() {
	# DO NOT COMPILE WITH OPTIMISATIONS (bug #22365)
	# That is a note to the devs.  IF you are a user, go ahead and optimise
	# if you want, but we won't support bugs associated with that.
	make INSTPREFIX=${D} || die
}

src_install() {
	# needed since the Makefile doesn't do 'mkdir -p $(BINDIR)'
	dodir /usr/bin

	make INSTPREFIX=${D} install || die

	exeinto /etc/acpi
	newexe ${FILESDIR}/${P}-default.sh default.sh || die

	insinto /etc/acpi/events
	newins ${FILESDIR}/${P}-default default || die

	dodoc README Changelog TODO

	exeinto /etc/init.d
	newexe ${FILESDIR}/acpid.rc6 acpid || die

	if use doc; then
		docinto examples
		dodoc samples/{acpi_handler.sh,sample.conf}

		docinto examples/battery
		dodoc samples/battery/*

		docinto examples/panasonic
		dodoc samples/panasonic/*
	fi
}
