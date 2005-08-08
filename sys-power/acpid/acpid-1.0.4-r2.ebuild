# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpid/acpid-1.0.4-r2.ebuild,v 1.2 2005/08/08 17:58:00 brix Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Daemon for Advanced Configuration and Power Interface"
HOMEPAGE="http://acpid.sourceforge.net"
SRC_URI="mirror://sourceforge/acpid/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 -ppc x86"
IUSE="doc logrotate"

DEPEND="sys-apps/sed
		virtual/libc
		virtual/linux-sources"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Fix building with gcc4
	epatch ${FILESDIR}/${P}-gcc4.patch

	# do not treat warnings as errors, bug #90873
	sed -i -e "s:-Werror::" ${S}/Makefile
}

src_compile() {
	# DO NOT COMPILE WITH OPTIMISATIONS (bug #22365)
	# That is a note to the devs.  IF you are a user, go ahead and optimise
	# if you want, but we won't support bugs associated with that.
	make CC="$(tc-getCC)" INSTPREFIX="${D}" || die
}

src_install() {
	# needed since the Makefile doesn't do 'mkdir -p $(BINDIR)'
	dodir /usr/bin

	make INSTPREFIX="${D}" install || die

	exeinto /etc/acpi
	newexe ${FILESDIR}/${P}-default.sh default.sh || die

	insinto /etc/acpi/events
	newins ${FILESDIR}/${P}-default default || die

	dodoc README Changelog TODO

	newinitd ${FILESDIR}/${P}-init.d acpid || die

	if use doc; then
		docinto examples
		dodoc samples/{acpi_handler.sh,sample.conf}

		docinto examples/battery
		dodoc samples/battery/*

		docinto examples/panasonic
		dodoc samples/panasonic/*
	fi

	if use logrotate; then
		insinto /etc/logrotate.d
		newins ${FILESDIR}/${P}-logrotate acpid || die
	fi
}

pkg_postinst() {
	echo
	einfo "You may wish to read the Gentoo Linux Power Management Guide,"
	einfo "which can be found online at:"
	einfo "    http://www.gentoo.org/doc/en/power-management-guide.xml"
	echo
}
