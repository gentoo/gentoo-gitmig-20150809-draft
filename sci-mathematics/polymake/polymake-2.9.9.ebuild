# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/polymake/polymake-2.9.9.ebuild,v 1.1 2010/11/16 23:33:43 tomka Exp $

EAPI=2

inherit eutils flag-o-matic

DESCRIPTION="research tool for polyhedral geometry and combinatorics"
SRC_URI="http://www.opt.tu-darmstadt.de/polymake/lib/exe/fetch.php/download/${P}.tar.bz2"

HOMEPAGE="http://www.opt.tu-darmstadt.de/polymake"

IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

# TODO: Drop java.
DEPEND="dev-libs/gmp
	dev-libs/libxml2
	dev-perl/XML-LibXML
	dev-libs/libxslt
	dev-perl/XML-LibXSLT
	dev-perl/XML-Writer
	dev-perl/Term-ReadLine-Gnu
	>=virtual/jdk-1.5.0"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PV}-gentoo-binutils.patch"
	sed -i '/system "strip $to"/d' support/install.pl

	einfo "During compile this package uses up to"
	einfo "750MB of RAM per process. Use MAKEOPTS=\"-j1\" if"
	einfo "you run into trouble."
}

src_configure () {
	export CXXOPT=$(get-flag -O)
	# Configure does not accept --host, therefore econf cannot be used
	./configure --prefix=/usr \
				--libdir=/usr/$(get_libdir)
}

src_install(){
	emake -j1 DESTDIR="${D}" install || die "install failed"
}

pkg_postinst(){
	elog "Polymake uses Perl Modules compiled during install."
	elog "You have to reinstall polymake after an upgrade of Perl."
	elog " "
	elog "This version of polymake does not ship docs. Sorry."
	elog "Help can be found on http://www.opt.tu-darmstadt.de/polymake_doku/ "
	elog " "
	elog "On first start, polymake will ask you about the locations"
	elog "of external programs it can use."
	elog "If the initial run crashes, please report to the developers."
}
