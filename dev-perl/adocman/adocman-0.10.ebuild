# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/adocman/adocman-0.10.ebuild,v 1.1 2003/12/01 17:27:52 rizzo Exp $

DESCRIPTION="Automation tool for Sourceforge.net DocManager handling"
HOMEPAGE="http://sitedocs.sourceforge.net/projects/adocman/adocman.html"
SRC_URI="mirror://sourceforge/sitedocs/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/Crypt-SSLeay
		dev-perl/Digest-MD5
		dev-perl/TermReadKey"

src_install() {
	eval `perl '-V:installarchlib'`
	ARCH_LIB=${installarchlib}
	dodir ${ARCH_LIB}/Alexandria
	insinto ${ARCH_LIB}/Alexandria
	doins Alexandria/Client.pm Alexandria/Docman.pm

	exeinto /usr/bin
	doexe adocman xml_export

	dodoc README LICENSE TODO
	dohtml adocman.html xml_export.html
}
