# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/siege/siege-2.60.ebuild,v 1.4 2004/09/20 10:55:39 ka0ttic Exp $

DESCRIPTION="A HTTP regression testing and benchmarking utility"
HOMEPAGE="http://www.joedog.org/siege/"
SRC_URI="ftp://sid.joedog.org/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ppc"
SLOT="0"
IUSE="ssl"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6d )"
RDEPEND="${DEPEND}
	dev-lang/perl"

src_compile() {
	econf $(use_with ssl) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" \
		SIEGERC="${S}/siegerc-example" \
		install || die
	dodoc AUTHORS ChangeLog INSTALL MACHINES README \
		KNOWNBUGS siegerc-example
	use ssl && dodoc README.https
}
