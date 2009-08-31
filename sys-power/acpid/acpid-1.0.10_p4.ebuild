# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpid/acpid-1.0.10_p4.ebuild,v 1.1 2009/08/31 22:29:13 loki_val Exp $

inherit toolchain-funcs

MY_P="${P%_p*}-netlink${PV#*_p}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Daemon for Advanced Configuration and Power Interface"
HOMEPAGE="http://acpid.sourceforge.net"
SRC_URI="http://tedfelix.com/linux/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 -ppc ~x86"
IUSE=""

DEPEND="sys-apps/sed"
RDEPEND=""

src_unpack() {
	unpack ${A}
	sed -i -e '/^CFLAGS /{s:=:+=:;s:-Werror::;s:-O2 -g::}' "${S}"/Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" INSTPREFIX="${D}" || die "emake failed"
	emake -C kacpimon CFLAGS="${CFLAGS} -fno-strict-aliasing" CC="$(tc-getCC)" INSTPREFIX="${D}" || die "emake failed"
}

src_install() {
	emake INSTPREFIX="${D}" install || die "emake install failed"

	dobin kacpimon/kacpimon || die "kacpimon failed to install"
	newdoc kacpimon/README README-KACPIMON

	exeinto /etc/acpi
	newexe "${FILESDIR}"/${PN}-1.0.6-default.sh default.sh || die
	insinto /etc/acpi/events
	newins "${FILESDIR}"/${PN}-1.0.4-default default || die

	dodoc README Changelog TODO || die

	newinitd "${FILESDIR}"/${PN}-1.0.6-init.d acpid || die
	newconfd "${FILESDIR}"/${PN}-1.0.6-conf.d acpid || die

	docinto examples
	dodoc samples/{acpi_handler.sh,sample.conf} || die

	docinto examples/battery
	dodoc samples/battery/* || die

	docinto examples/panasonic
	dodoc samples/panasonic/* || die
}

pkg_postinst() {
	echo
	einfo "You may wish to read the Gentoo Linux Power Management Guide,"
	einfo "which can be found online at:"
	einfo "    http://www.gentoo.org/doc/en/power-management-guide.xml"
	echo
}
