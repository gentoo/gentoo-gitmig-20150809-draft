# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook2X/docbook2X-0.6.1-r1.ebuild,v 1.5 2003/09/05 22:37:21 msterret Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Tools to convert docbook to man and info"
SRC_URI="mirror://sourceforge/docbook2x/${P}.tar.gz"
HOMEPAGE="http://docbook2x.sourceforge.net"

SLOT="0"
KEYWORDS="x86 ppc sparc "
LICENSE="GPL-2"

DEPEND=""

RDEPEND=">=dev-perl/XML-Writer-0.4
	>=dev-perl/XML-XSLT-0.31
	>=dev-perl/SGMLSpm-1.03"
	#>=dev-libs/libxslt-0.5.0"

src_install () {

	insinto /usr/lib/perl5/site_perl/5.6.1/XML/DOM
	doins XML/DOM/Map.pm
	insinto /usr/lib/perl5/site_perl/5.6.1/XML
	doins XML/SGMLSpl.pm
	insinto /usr/share/sgml/docbook/db2X-customization/common
	doins xslt/common/*
	insinto /usr/share/sgml/docbook/db2X-customization/lib
	doins xslt/lib/*
	insinto /usr/share/sgml/docbook/db2X-customization/texi
	doins xslt/texi/*
	insinto /usr/share/sgml/docbook/db2X-customization/dtd
	doins dtd/Texi-XML
	exeinto /usr/bin
	for exe in docbook2man docbook2manxml docbook2texi docbook2texixml texi_xml man_xml
	do
		mv ${exe} ${exe}.pl
		doexe ${exe}.pl
	done
	doexe docbook2man-spec.pl docbook2texi-spec.pl manpage_makelinks.pl
	einfo "To avoid conflict with docbook-sgml-utils, which is much more widely used,"
	einfo "all executables have been renamed to *.pl."
}
