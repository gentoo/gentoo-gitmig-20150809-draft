# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook2X/docbook2X-0.6.1.ebuild,v 1.1 2001/03/18 00:06:08 achim Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${PN}
DESCRIPTION="Tolls to convert docbook to man and info"
SRC_URI="http://download.sourceforge.net/docbook2x/${A}"
HOMEPAGE="http://docbook2x.sourceforge.net"

DEPEND=">=dev-perl/XML-DOM-1.25
	>=dev-perl/XML-Parser-2.30
	>=dev-perl/XML-Writer-0.4
	>=dev-perl/SGMLSpm-1.03
	>=gnome-libs/libxslt-0.5.0"

src_install () {

    insinto /usr/lib/perl5/site_perl/5.6.0/XML/DOM
    doins XML/DOM/Map.pm
    insinto /usr/lib/perl5/site_perl/5.6.0/XML
    doins XML/SGMLSpl.pm
    insinto /usr/share/sgml/docbook/db2X/common
    doins xslt/common/*
    insinto /usr/share/sgml/docbook/db2X/lib
    doins xslt/lib/*
    insinto /usr/share/sgml/docbook/db2X/texi
    doins xslt/texi/*
    insinto /usr/share/sgml/docbook/db2X/dtd
    newins dtd/Texi-XML Texi-XML.dtd
    exeinto /usr/bin
    doexe docbook2man docbook2manxml docbook2texi docbook2texixml
    doexe docbook2man-spec.pl docbook2texi-spec.pl texi_xml man_xml
    doexe manpage_makelinks.pl
}

