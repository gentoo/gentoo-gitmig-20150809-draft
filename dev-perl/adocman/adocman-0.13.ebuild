# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/adocman/adocman-0.13.ebuild,v 1.4 2006/02/13 14:15:50 mcummings Exp $

DESCRIPTION="Automation tool for Sourceforge.net DocManager handling"
HOMEPAGE="http://sitedocs.sourceforge.net/projects/adocman/adocman.html"
SRC_URI="mirror://sourceforge/sitedocs/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/Crypt-SSLeay
		virtual/perl-Digest-MD5
		dev-perl/TermReadKey"

src_install() {
	eval `perl '-V:installarchlib'`
	ARCH_LIB=${installarchlib}
	dodir ${ARCH_LIB}/Alexandria
	insinto ${ARCH_LIB}/Alexandria
	doins Alexandria/Client.pm Alexandria/Docman.pm Alexandria/Tracker.pm

	exeinto /usr/bin
	doexe adocman xml_export atracker

	dodoc README LICENSE TODO
	dohtml adocman.html xml_export.html
}
