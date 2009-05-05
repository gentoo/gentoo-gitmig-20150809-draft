# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/hepmc/hepmc-2.04.00.ebuild,v 1.6 2009/05/05 19:37:24 fauli Exp $

MYP=HepMC-${PV}

DESCRIPTION="Event Record for Monte Carlo Generators"
HOMEPAGE="https://savannah.cern.ch/projects/hepmc/"
SRC_URI="http://lcgapp.cern.ch/project/simu/HepMC/download/${MYP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa sparc x86"
IUSE="doc examples gev cm"

DEPEND=""

S="${WORKDIR}/${MYP}"

src_compile() {
	# random default choice: use MeV over GeV and mm over cm
	local length_conf="MM"
	use cm && length_conf="CM"
	local momentum_conf="MEV"
	use gev && momentum_conf="GEV"
	econf \
		--with-length=${length_conf} \
		--with-momentum=${momentum_conf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		INSTALLDIR=/usr/share/doc/${PF}/examples \
		doc_installdir=/usr/share/doc/${PF} \
		install || die "emake install failed"

	dodoc README AUTHORS ChangeLog
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r doc/html || die
	else
		rm -f "${D}"/usr/share/doc/${PF}/*pdf
	fi
	use examples || rm -rf "${D}"/usr/share/doc/${PF}/examples
}
