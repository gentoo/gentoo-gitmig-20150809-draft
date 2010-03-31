# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpid/acpid-1.0.4-r5.ebuild,v 1.4 2010/03/31 13:31:18 ssuominen Exp $

inherit eutils toolchain-funcs

DV="acpid_1.0.4-7.1"
DESCRIPTION="Daemon for Advanced Configuration and Power Interface"
HOMEPAGE="http://acpid.sourceforge.net"
SRC_URI="mirror://sourceforge/acpid/${P}.tar.gz
	mirror://debian/pool/main/a/acpid/${DV}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 -ppc x86"
IUSE="doc logrotate"

DEPEND="sys-apps/sed"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ../${DV}.diff
}

src_compile() {
	# DO NOT COMPILE WITH OPTIMISATIONS (bug #22365)
	# That is a note to the devs.  IF you are a user, go ahead and optimise
	# if you want, but we won't support bugs associated with that.
	emake CC="$(tc-getCC)" INSTPREFIX="${D}" || die "emake failed"
}

src_install() {
	# needed since the Makefile doesn't do 'mkdir -p $(BINDIR)'
	dodir /usr/bin

	emake INSTPREFIX="${D}" install || die "emake install failed"

	exeinto /etc/acpi
	doexe examples/default.sh
	insinto /etc/acpi/events
	doins examples/default

	dodoc README Changelog TODO

	newinitd "${FILESDIR}"/${P}-init.d acpid

	docinto examples
	dodoc samples/{acpi_handler.sh,sample.conf}
	dodoc examples/ac{,.sh}

	docinto examples/battery
	dodoc samples/battery/*

	docinto examples/panasonic
	dodoc samples/panasonic/*

	if use logrotate; then
		insinto /etc/logrotate.d
		newins debian/acpid.logrotate acpid
	fi
}

pkg_postinst() {
	echo
	einfo "You may wish to read the Gentoo Linux Power Management Guide,"
	einfo "which can be found online at:"
	einfo "    http://www.gentoo.org/doc/en/power-management-guide.xml"
	echo
}
