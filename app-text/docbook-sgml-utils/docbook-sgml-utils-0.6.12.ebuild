# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-sgml-utils/docbook-sgml-utils-0.6.12.ebuild,v 1.17 2004/10/18 16:40:21 usata Exp $

inherit eutils

MY_PN=${PN/-sgml/}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Shell scripts to manage DocBook documents"
HOMEPAGE="http://sources.redhat.com/docbook-tools/"
SRC_URI="ftp://sources.redhat.com/pub/docbook-tools/new-trials/SOURCES/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"
IUSE="tetex"

DEPEND=">=dev-lang/perl-5
	app-text/docbook-dsssl-stylesheets
	app-text/openjade
	dev-perl/SGMLSpm
	app-text/docbook-xml-simple-dtd
	app-text/docbook-xml-dtd
	~app-text/docbook-sgml-dtd-3.0
	~app-text/docbook-sgml-dtd-3.1
	~app-text/docbook-sgml-dtd-4.0
	~app-text/docbook-sgml-dtd-4.1
	tetex? ( app-text/jadetex )
	|| ( net-www/lynx net-www/links )"

src_unpack() {
	unpack ${A}
	cd ${S} || die
	patch -p1 < ${FILESDIR}/docbook-sgml-utils-frontend.patch || die
	epatch ${FILESDIR}/${PN}-head-jw.patch
}

src_install() {
	einstall htmldir=${D}/usr/share/doc/${PF}/html
	dodoc AUTHORS ChangeLog NEWS README TODO
}
