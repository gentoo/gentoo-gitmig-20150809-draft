# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snortalog/snortalog-2.4.0.ebuild,v 1.5 2005/06/25 02:03:52 ticho Exp $

inherit eutils

MY_P="${PN}_v${PV}"

DESCRIPTION="a powerful perl script that summarizes snort logs"
SRC_URI="http://jeremy.chartier.free.fr/${PN}/${MY_P}.tgz
	tcltk? ( mirror://gentoo/${P}-fix-gui.diff.gz )"
HOMEPAGE="http://jeremy.chartier.free.fr/snortalog/"

KEYWORDS="~x86 ~ppc ~amd64"
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
	[[ -d ${S} ]] || mkdir ${S}
	cd ${S}
	unpack ${A}

	# one file created at a time ( pdf or html )
	epatch ${FILESDIR}/${P}-limit-args.diff

	use tcltk || epatch ${FILESDIR}/${P}-notcltk.diff
	use tcltk && epatch ${DISTDIR}/${P}-fix-gui.diff.gz

	# fix paths, erroneous can access message
	sed -i -e "s:\(modules/\):/usr/lib/snortalog/${PV}/\1:g" \
		-e 's:\($domains_file = "\)conf/\(domains\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:\($rules_file = "\)conf/\(rules\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:\($hw_file = "\)conf/\(hw\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:\($lang_file ="\)conf/\(lang\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:Can access:Cannot access:' \
		snortalog.pl || die "sed snortalog.pl failed"
}

src_install () {
	dobin snortalog.pl || die

	insinto /etc/${PN}
	doins conf/{domains,hw,lang,rules}

	insinto /usr/lib/${PN}/${PV}/modules
	doins -r modules/*

	cd doc
	dodoc CHANGES
}
