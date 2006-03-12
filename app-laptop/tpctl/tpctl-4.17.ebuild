# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/tpctl/tpctl-4.17.ebuild,v 1.1 2006/03/12 02:27:35 steev Exp $

MY_P=${PN}_${PV}

DESCRIPTION="Thinkpad system control user space programs"

HOMEPAGE="http://tpctl.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE="tpctlir"

DEPEND="app-laptop/thinkpad
		dev-lang/perl
		sys-libs/ncurses"

src_compile() {
	emake || die "emake failed"

	if use tpctlir; then
		emake -C tpctlir || die "emake -C tpctlir failed"
	fi
}

src_install() {
	if use tpctlir; then
		dodir /usr/sbin
		newdoc tpctlir/README README.tpctlir
		doman tpctlir/tpctlir.8
	fi

	emake DEST=${D} install_libraries install_binaries install_man || die "emake install failed"

	newinitd ${FILESDIR}/apmiser.rc apmiser

	dodoc ChangeLog SUPPORTED-MODELS TROUBLESHOOTING AUTHORS README VGA-MODES
	newdoc apmiser/README README.apmiser
}
