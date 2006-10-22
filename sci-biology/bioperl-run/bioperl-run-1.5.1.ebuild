# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bioperl-run/bioperl-run-1.5.1.ebuild,v 1.3 2006/10/22 17:28:19 ribosome Exp $

inherit perl-app eutils

DESCRIPTION="Perl tools for bioinformatics - Analysis run modules"
HOMEPAGE="http://www.bioperl.org/"
#SRC_URI="http://www.cpan.org/modules/by-module/Bio/${P}.tar.gz"
SRC_URI="http://www.bioperl.org/ftp/DIST/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="
	dev-perl/Algorithm-Diff
	virtual/perl-File-Temp
	dev-perl/IO-String
	dev-perl/XML-Parser
	sci-biology/bioperl"

DEPEND=""

src_compile() {
	perl-module_src_compile || die "compile failed"
}

src_install() {
	mydoc="AUTHORS BUGS INSTALL.PROGRAMS README"
	perl-module_src_install

	# bioperl scripts and examples
	einfo 'Adding bioperl examples and scripts to /usr/share/...'
	dodir /usr/share/${PF}/scripts
	#insinto /usr/share/${PF}/scripts
	cd "${S}"/scripts/
	tar cf - ./ | ( cd "${D}"/usr/share/${PF}/scripts; tar xf -)
	dodir /usr/share/${PF}/examples
	cd "${S}"/examples/
	tar cf - ./ | ( cd "${D}"/usr/share/${PF}/examples; tar xf -)
	cd "${S}"
}

src_test() {
	make test
	perl-module_src_test || die "src test failed"
}
