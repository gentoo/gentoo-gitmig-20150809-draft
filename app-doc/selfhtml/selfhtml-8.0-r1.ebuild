# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/selfhtml/selfhtml-8.0-r1.ebuild,v 1.8 2004/11/05 04:07:02 pylon Exp $

S=${WORKDIR}
TARGET=/usr/share/doc/${PF}/html
DESCRIPTION="\"The\" German HTML/XHTML/CSS/XML/DHTML/CGI/Perl/JavaScript Documentation"
SRC_URI="http://www.stud.uni-goettingen.de/software/selfhtml80.zip
	http://selfaktuell.teamone.de/extras/selfhtml8err01.zip"
HOMEPAGE="http://selfhtml.org"
DEPEND="app-arch/unzip"
SLOT="0"
LICENSE="selfhtml"
KEYWORDS="x86 ppc sparc alpha mips hppa amd64"
IUSE=""

src_install() {
	dodir ${TARGET}
	cp -a ${S}/* ${D}${TARGET}
}
