# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/jags/jags-2.2.0.ebuild,v 1.1 2011/02/12 11:50:38 tomka Exp $

EAPI=2
inherit autotools-utils

MYP="JAGS-${PV}"

DESCRIPTION="Just Another Gibbs Sampler for Bayesian MCMC simulation"
HOMEPAGE="http://www-fis.iarc.fr/~martyn/software/jags/"
SRC_URI="mirror://sourceforge/project/mcmc-jags/JAGS/2.x/Source/${MYP}.tar.gz"
LICENSE="GPL-2"
IUSE=""

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="virtual/blas
	virtual/lapack"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MYP}"

DOCS=(README NEWS TODO AUTHORS)

src_configure() {
	myeconfags=(
		--with-blas="$(pkg-config --libs blas)"
		--with-lapack="$(pkg-config --libs lapack)"
	)
	autotools-utils_src_configure
}
