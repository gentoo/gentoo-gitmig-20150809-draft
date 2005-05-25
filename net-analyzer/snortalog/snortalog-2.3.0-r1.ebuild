# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snortalog/snortalog-2.3.0-r1.ebuild,v 1.5 2005/05/25 14:03:38 mcummings Exp $

inherit eutils

MY_P="${PN}_v${PV}"

DESCRIPTION="a powerful perl script that summarizes snort logs"
SRC_URI="http://jeremy.chartier.free.fr/${PN}/${MY_P}.tgz"
HOMEPAGE="http://jeremy.chartier.free.fr/snortalog/
	tcltk? ( mirror://gentoo/${P}-fix-gui.diff.gz )"

KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE="tcltk"

S="${WORKDIR}/${MY_P%.?}"

RDEPEND="dev-lang/perl
	perl-core/Getopt-Long
	perl-core/DB_File
	dev-perl/HTML-HTMLDoc
	tcltk? ( dev-perl/perl-tk
			 dev-perl/GDGraph )"

src_unpack() {
	unpack ${MY_P}.tgz && cd ${S}
	# one file created at a time ( pdf or html )
	epatch ${FILESDIR}/${P}-limit-args.diff

	use tcltk || epatch ${FILESDIR}/${PN}-notcltk.diff
	use tcltk && epatch ${DISTDIR}/${P}-fix-gui.diff.gz
	# fix paths, erroneous can access message
	sed -i -e "s:\(modules/\):/usr/lib/snortalog/${PV}/\1:g" \
		-e 's:\($domains_file = "\)\(domains\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:\($rules_file = "\)\(rules\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:\($hw_file = "\)\(hw\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:\($lang_file = "\)\(lang\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:Can access:Can not access:' \
		snortalog.pl || die "sed snortalog.pl failed"
}

src_install () {
	dobin snortalog.pl || die

	insinto /etc/${PN}
	doins domains hw lang rules

	insinto /usr/lib/${PN}/${PV}/modules
	doins modules/*
	dodoc CHANGES README snortalog_v2.2.0.pdf
}
