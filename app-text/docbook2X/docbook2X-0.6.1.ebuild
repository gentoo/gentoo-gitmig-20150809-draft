# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook2X/docbook2X-0.6.1.ebuild,v 1.12 2002/08/16 02:42:01 murphy Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Tolls to convert docbook to man and info"
SRC_URI="http://download.sourceforge.net/docbook2x/${P}.tar.gz"
HOMEPAGE="http://docbook2x.sourceforge.net"

SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"
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
	doexe docbook2man docbook2manxml docbook2texi docbook2texixml
	doexe docbook2man-spec.pl docbook2texi-spec.pl texi_xml man_xml
	doexe manpage_makelinks.pl
}
