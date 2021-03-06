# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-SPF/Mail-SPF-2.9.0.ebuild,v 1.1 2015/07/21 22:30:44 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=JMEHNLE
MODULE_SECTION=mail-spf
MODULE_VERSION=v2.9.0
inherit perl-module

DESCRIPTION="An object-oriented implementation of Sender Policy Framework"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x86-fbsd"
IUSE="test"

RDEPEND="
	dev-perl/Error
	>=dev-perl/Net-DNS-0.620.0
	>=dev-perl/NetAddr-IP-4
	>=dev-perl/URI-1.130.0
	>=dev-perl/Net-DNS-Resolver-Programmable-0.3.0
	virtual/perl-version
	!!dev-perl/Mail-SPF-Query
"
DEPEND="${RDEPEND}
	>=dev-perl/Module-Build-0.280.500
	>=dev-perl/Net-DNS-Resolver-Programmable-0.3.0
	test? ( virtual/perl-Test-Simple )
"

SRC_TEST="do parallel"

src_prepare() {
	perl-module_src_prepare
	sed -i -e "s:spfquery:spfquery.pl:" Build.PL || die "sed failed"
	mv "${S}"/bin/spfquery "${S}"/bin/spfquery.pl || die "renaming spfquery failed"
}

pkg_postinst() {
	elog "The spfquery script was renamed to spfquery.pl because of file collisions."
}
