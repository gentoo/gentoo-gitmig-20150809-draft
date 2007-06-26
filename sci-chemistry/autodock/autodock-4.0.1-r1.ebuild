# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/autodock/autodock-4.0.1-r1.ebuild,v 1.1 2007/06/26 18:42:29 ribosome Exp $

MY_PN="autodocksuite"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A suite of automated docking tools"
HOMEPAGE="http://autodock.scripps.edu/"
SRC_URI="mirror://gentoo/${MY_PN}/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}/src"

src_compile() {
	cd autodock/
	econf || die "AutoDock econf failed."
	emake || die "AutoDock emake failed."
	cd ..

	cd autogrid/
	econf || die "AutoGrid econf failed."
	emake || die "AutoGrid emake failed."
	cd ..
}

src_install() {
	cd "${S}/autodock"
	dobin autodock4 || die "Failed to install autodock binary."
	dodoc AUTHORS ChangeLog NEWS README || die \
			"Failed to install documentation."
	insinto "/usr/share/autodock"
	doins AD4_parameters.dat AD4_PARM99.dat || die \
			"Failed to install shared files."

	cd "${S}/autogrid"
	dobin autogrid4 || die "Failed to install autogrid binary."
}

src_test() {
	cd "${S}/autodock/Tests"
	python test_autodock4.py || die "AutoDock tests failed."
	cd "${S}/autogrid/Tests"
	python test_autogrid4.py || die "AutoGrid tests failed."
}

pkg_postinst() {
	echo
	einfo "The AutoDock development team requests all users to fill out the"
	einfo "registration form at:"
	einfo
	einfo "\thttp://autodock.scripps.edu/downloads/autodock-registration"
	einfo
	einfo "The number of unique users of AutoDock is used by Prof. Arthur J."
	einfo "Olson and the Scripps Research Institude to support grant"
	einfo "applications."
	echo
}
