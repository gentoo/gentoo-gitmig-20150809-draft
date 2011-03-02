# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/polymake/polymake-2.9.9-r1.ebuild,v 1.2 2011/03/02 21:08:21 jlec Exp $

EAPI=2

inherit eutils flag-o-matic

DESCRIPTION="research tool for polyhedral geometry and combinatorics"
SRC_URI="http://www.opt.tu-darmstadt.de/polymake/lib/exe/fetch.php/download/${P}.tar.bz2"

HOMEPAGE="http://www.opt.tu-darmstadt.de/polymake"

IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/gmp
	dev-libs/libxml2:2
	dev-perl/XML-LibXML
	dev-libs/libxslt
	dev-perl/XML-LibXSLT
	dev-perl/XML-Writer
	dev-perl/Term-ReadLine-Gnu"
RDEPEND="${DEPEND}"

src_prepare() {
	# Upstream provided patch. Remove in version 3.0!
	epatch "${FILESDIR}/${PV}-gentoo-binutils.patch"
	epatch "${FILESDIR}/${PV}-drop-jreality.patch"
	rm -rf java_build/jreality

	# Don't strip
	sed -i '/system "strip $to"/d' support/install.pl || die

	einfo "During compile this package uses up to"
	einfo "750MB of RAM per process. Use MAKEOPTS=\"-j1\" if"
	einfo "you run into trouble."
}

src_configure () {

	export CXXOPT=$(get-flag -O)
	# Configure does not accept --host, therefore econf cannot be used
	# Note 'libdir' does not mean where to put .so files!
	# --libdir=/usr/$(get_libdir) \
	./configure --prefix=/usr \
		--without-java \
		--without-prereq \
		${myconf} || die
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
	elog "Visualization in polymake is via jreality which ships pre-compiled"
	elog "binary libraries.  Until this situation is resolved, support for"
	elog "jreality has been dropped.  Please contribute to Bug #346073 to "
	elog "make jreality available in Gentoo."
}
