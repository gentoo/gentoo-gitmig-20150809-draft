# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/apbs/apbs-0.3.2.ebuild,v 1.1 2005/10/20 01:22:57 ribosome Exp $

inherit eutils fortran

DESCRIPTION=" Software for evaluating the electrostatic properties of nanoscale biomolecular systems"
LICENSE="GPL-2"
HOMEPAGE="http://agave.wustl.edu/apbs/"
SRC_URI="http://agave.wustl.edu/apbs/download/dist/${P}.tar.gz"

SLOT="0"
IUSE="blas"
KEYWORDS="~x86"

DEPEND="blas? ( virtual/blas )
		sys-libs/readline
		dev-libs/maloc"

pkg_setup() {
	need_fortran g77
}

src_compile() {
	# use blas
	use blas && local myconf="--with-blas=-lblas"

	# configure 
	econf ${myconf} || die "configure failed"

	# build
	make || die "make failed"
}

src_install() {

	# install apbs binary
	dobin bin/apbs || die "failed to install apbs binary"

	# fix up and install examples
	sed -e "s|\${bindir}|/usr/bin|" \
		-i examples/ion-pmf/runme || \
		die "failed fixing ion-pmf/runme file"

	sed -e "s|bindir=''|bindir=/usr/bin|" \
		-i examples/point-pmf/runme.sh || \
		die "failed fixing point-pmf/runme.sh"

	insinto /usr/share/doc/${PF}/examples
	doins -r examples/* || die "failed to install examples"

	# install docs
	insinto /usr/share/doc/${PF}/html/programmer
	doins doc/html/programmer/* || die "failed to install html docs"

	insinto /usr/share/doc/${PF}/html/tutorial
	doins doc/html/tutorial/* || die "failed to install html docs"

	insinto /usr/share/doc/${PF}/html/user-guide
	doins doc/html/user-guide/* || die "failed to install html docs"
}
