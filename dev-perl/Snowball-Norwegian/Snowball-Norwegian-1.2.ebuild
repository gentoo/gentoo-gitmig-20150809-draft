# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Snowball-Norwegian/Snowball-Norwegian-1.2.ebuild,v 1.7 2008/04/30 15:15:58 tove Exp $

inherit perl-module multilib

DESCRIPTION="Porters stemming algorithm for Norwegian"
HOMEPAGE="http://search.cpan.org/~asksh/"
SRC_URI="mirror://cpan/authors/id/A/AS/ASKSH/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	dev-perl/module-build"

src_install() {
	perl-module_src_install
	local version
	eval `perl '-V:version'`
	perl_version=${version}
	local myarch
	eval `perl '-V:archname'`
	myarch=${archname}

	if [ -f "${D}"/usr/$(get_libdir)/perl5/vendor_perl/${perl_version}/Lingua/Stem/Snowball/stemmer.pl ]; then
		mv \
		"${D}"/usr/$(get_libdir)/perl5/vendor_perl/${perl_version}/Lingua/Stem/Snowball/stemmer.pl \
		"${D}"/usr/$(get_libdir)/perl5/vendor_perl/${perl_version}/Lingua/Stem/Snowball/no-stemmer.pl
	fi
}

pkg_postinst() {
	perl-module_pkg_postinst
	elog "The stemmer.pl that ships with this distribution has been renamed to"
	elog "no-stemmer.pl to avoid collisions with other Lingua::Stem packages."
}
