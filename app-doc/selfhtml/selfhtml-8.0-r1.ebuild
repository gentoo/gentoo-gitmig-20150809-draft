# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/selfhtml/selfhtml-8.0-r1.ebuild,v 1.1 2004/03/08 16:54:45 pylon Exp $

S=${WORKDIR}
DESCRIPTION="\"The\" German HTML/XHTML/CSS/XML/DHTML/CGI/Perl/JavaScript Documentation"
SRC_URI="http://www.stud.uni-goettingen.de/software/selfhtml80.zip
	http://selfaktuell.teamone.de/extras/selfhtml8err01.zip"
HOMEPAGE="http://selfhtml.teamone.de"
DEPEND=""
SLOT="0"
LICENSE="selfhtml"
KEYWORDS="x86 ppc sparc alpha mips hppa"
IUSE=""

src_install() {
	dohtml -r *
}
