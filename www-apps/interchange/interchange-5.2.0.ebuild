# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/interchange/interchange-5.2.0.ebuild,v 1.1 2005/05/03 11:27:29 beu Exp $

inherit eutils

DESCRIPTION="Interchange is an open source alternative to commercial commerce servers and application server/component applications."
SRC_URI="http://ftp.icdevgroup.org/${PN}/5.2/tar/${P}.tar.gz"
HOMEPAGE="http://www.icdevgroup.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE="postgres mysql"

DEPEND=">=dev-lang/perl-5.6.0
		dev-perl/IniConf
		dev-perl/HTML-Parser
		dev-perl/ShadowHash
		dev-perl/Business-FedEx-DirectConnect
		dev-perl/Business-UPS
		dev-perl/Safe-Hole"
RDEPEND="
	${DEPEND}
	postgres? ( >=dev-perl/DBI-1.38 dev-perl/DBD-Pg )
	mysql? ( >=dev-perl/DBI-1.38 dev-perl/DBD-mysql  dev-perl/SQL-Statement )
	net-www/apache"

pkg_setup() {
	enewuser interch >/dev/null
}

src_unpack() {
	unpack ${A}
	cd ${S}
	echo -e "\n\n" > out
	sed -i "s|/usr/local/interchange|${D}/var/interchange|" Makefile.PL
	sed -i "s|\$PERL Makefile.PL \$\*|\$PERL Makefile.PL \$\* < out|" configure
}

src_install () {
	./configure || die "configure failed" # this actually installs
	cd ${D}/var/interchange/bin
	for file in *; do
		dosed /var/interchange/bin/${file}
	done
}

pkg_postinst () {
	einfo "Now run /var/interchange/bin/makecat"
}
