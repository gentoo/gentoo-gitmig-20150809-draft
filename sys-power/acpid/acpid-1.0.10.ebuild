# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpid/acpid-1.0.10.ebuild,v 1.1 2009/05/03 09:26:20 loki_val Exp $

inherit toolchain-funcs

MY_P="${P}-netlink2"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Daemon for Advanced Configuration and Power Interface"
HOMEPAGE="http://acpid.sourceforge.net"
SRC_URI="http://tedfelix.com/linux/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-ppc ~ia64 ~alpha ~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/sed"
RDEPEND=""

src_unpack() {
	unpack ${A}
	sed -i -e '/^CFLAGS /{s:=:+=:;s:-Werror::;s:-O2 -g::}' "${S}"/Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" INSTPREFIX="${D}" || die "emake failed"
}

src_install() {
	emake INSTPREFIX="${D}" install || die "emake install failed"

	exeinto /etc/acpi
	newexe "${FILESDIR}"/${PN}-1.0.6-default.sh default.sh || die
	insinto /etc/acpi/events
	newins "${FILESDIR}"/${PN}-1.0.4-default default || die

	dodoc README Changelog TODO || die

	newinitd "${FILESDIR}"/${PN}-1.0.6-init.d acpid || die
	newconfd "${FILESDIR}"/${PN}-1.0.6-conf.d acpid || die

	docinto examples
	dodoc samples/{acpi_handler.sh,sample.conf}

	docinto examples/battery
	dodoc samples/battery/*

	docinto examples/panasonic
	dodoc samples/panasonic/*
}

pkg_postinst() {
	echo
	einfo "You may wish to read the Gentoo Linux Power Management Guide,"
	einfo "which can be found online at:"
	einfo "    http://www.gentoo.org/doc/en/power-management-guide.xml"
	echo
}
