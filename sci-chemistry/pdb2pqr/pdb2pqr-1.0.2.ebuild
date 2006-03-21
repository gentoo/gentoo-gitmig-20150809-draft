# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pdb2pqr/pdb2pqr-1.0.2.ebuild,v 1.1 2006/03/21 17:07:14 markusle Exp $

inherit eutils fortran python multilib

DESCRIPTION="pdb2pqr is an automated pipeline for the setup, execution, and analysis of Poisson-Boltzmann electrostatics calculations"
LICENSE="GPL-2"
HOMEPAGE="http://pdb2pqr.sourceforge.net/"
SRC_URI="http://umn.dl.sourceforge.net/sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~x86"

DEPEND="dev-lang/python"

FORTRAN="g77 gfortran"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-gcc4-gentoo.patch
	epatch "${FILESDIR}"/${PN}-propka-gentoo.patch
}

src_install() {
	python_version
	INPATH="/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}"

	insinto "${INPATH}"
	doins __init__.py constants.py || \
		die "Setting up the pdb2pqr site-package failed."

	exeinto "${INPATH}"
	doexe ${PN}.py || die "Installing pdb2pqr failed."

	exeinto "${INPATH}"/propka
	doexe propka/_propkalib.so || \
		die "Failed to install propka."

	insinto "${INPATH}"/propka
	doins propka/propkalib.py propka/__init__.py || \
		die "Failed to install propka."

	insinto "${INPATH}"/src
	doins src/* || die "Installing of python scripts failed."

	insinto "${INPATH}"/dat
	doins dat/* || die "Installing data failed."

	into /usr/bin
	dosym "${INPATH}"/${PN}.py /usr/bin/${PN} \
		|| die "Failed to install symlink into /usr/bin."

	dodoc ChangeLog NEWS README AUTHORS || \
		die "Failed to install docs"
	dohtml doc/* || die "Failed to install html docs."
}

