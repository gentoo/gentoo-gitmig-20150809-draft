# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snortsnarf/snortsnarf-021111.1-r1.ebuild,v 1.2 2004/06/07 22:31:12 mr_bones_ Exp $

DESCRIPTION="Snort Snarf parses Snort log files, and converts them into easy-to-read HTML files."
HOMEPAGE="http://www.silicondefense.com/software/snortsnarf/"
MY_P="SnortSnarf-${PV}"
S=${WORKDIR}/${MY_P}
SRC_URI="http://www.silicondefense.com/software/snortsnarf/${MY_P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RDEPEND="dev-lang/perl
	dev-perl/Time-modules
	dev-perl/XML-Parser"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.7"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:"snort.alert":"snort".$dirsep."alert":g' snortsnarf.pl
}

src_install() {
	PERL_V=$( perl '-V:version' | awk -F "'" '{print $2}' )

	dodoc Usage COPYING Changes README README.SISR README.nmap2html \
		new-annotation-base.xml

	dobin snortsnarf.pl nmap2html/log2db.pl nmap2html/nmap2html.pl \
		nmap2html/nmaplog-dns.pl utilities/*

	dodir /var/www/localhost/snortsnarf/cgi-bin
	dodir /usr/lib/perl5/site_perl/$PERL_V/SnortSnarf

	insinto /var/www/localhost/snortsnarf/cgi-bin
	doins cgi/*

	cp -a include/* ${D}/usr/lib/perl5/site_perl/$PERL_V
}

pkg_postinst() {
	setup_anns_dir.pl /var/log/snortsnarf
}
