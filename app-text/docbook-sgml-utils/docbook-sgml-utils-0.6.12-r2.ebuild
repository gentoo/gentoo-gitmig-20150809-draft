# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-sgml-utils/docbook-sgml-utils-0.6.12-r2.ebuild,v 1.3 2004/04/07 21:44:18 vapier Exp $

inherit eutils

MY_PN=${PN/-sgml/}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Shell scripts to manage DocBook documents"
HOMEPAGE="http://sources.redhat.com/docbook-tools/"
SRC_URI="ftp://sources.redhat.com/pub/docbook-tools/new-trials/SOURCES/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~mips"
IUSE="tetex"

DEPEND=">=dev-lang/perl-5
	app-text/docbook-dsssl-stylesheets
	app-text/openjade
	dev-perl/SGMLSpm
	=app-text/docbook-xml-simple-dtd-4.1.2.4
	=app-text/docbook-xml-simple-dtd-1.0
	app-text/docbook-xml-dtd
	=app-text/docbook-sgml-dtd-3.0-r1
	=app-text/docbook-sgml-dtd-3.1-r1
	=app-text/docbook-sgml-dtd-4.0-r1
	=app-text/docbook-sgml-dtd-4.1-r1
	tetex? ( app-text/jadetex )
	|| ( net-www/lynx net-www/links )"

# including both xml-simple-dtd 4.1.2.4 and 1.0, to ease
# transition to simple-dtd 1.0, <obz@gentoo.org>

src_compile() {
	epatch ${FILESDIR}/${PN}-frontend.patch
	epatch ${FILESDIR}/${PN}-head-jw.patch
	econf || die
	make || die
}

src_install() {
	einstall htmldir=${D}/usr/share/doc/${PF}/html
	dodoc AUTHORS ChangeLog NEWS README TODO
}
