# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snortsnarf/snortsnarf-021111.1-r3.ebuild,v 1.1 2005/02/02 14:03:07 ka0ttic Exp $

inherit eutils webapp

MY_P="${P//s/S}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Snort Snarf parses Snort log files, and converts them into easy-to-read HTML files."
HOMEPAGE="http://www.silicondefense.com/software/snortsnarf/"
SRC_URI="http://www.silicondefense.com/software/snortsnarf/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/Time-modules
	dev-perl/XML-Parser"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.7"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:"snort.alert":"snort".$dirsep."alert":g' snortsnarf.pl \
		|| die "sed snortsnarf.pl failed"
	epatch ${FILESDIR}/${P}-fix-array-refs.diff
}

src_install() {
	webapp_src_preinst

	PERL_V=$( perl '-V:version' | awk -F "'" '{print $2}' )

	dodoc Usage COPYING Changes README README.SISR README.nmap2html \
		new-annotation-base.xml

	dobin snortsnarf.pl nmap2html/log2db.pl nmap2html/nmap2html.pl \
		nmap2html/nmaplog-dns.pl utilities/*

	dodir ${MY_CGIBINDIR}/snortsnarf/
	insinto ${MY_CGIBINDIR}/snortsnarf/
	doins cgi/*

	dodir /usr/lib/perl5/site_perl/$PERL_V/SnortSnarf
	cp -a include/* ${D}/usr/lib/perl5/site_perl/$PERL_V

	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst

	setup_anns_dir.pl /var/log/snortsnarf
}
