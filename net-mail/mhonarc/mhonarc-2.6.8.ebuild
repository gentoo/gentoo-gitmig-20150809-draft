# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mhonarc/mhonarc-2.6.8.ebuild,v 1.1 2003/12/18 20:06:03 kumba Exp $

IUSE=""

inherit perl-module
CATEGORY="net-mail"

MY_P="${P/mhonarc/MHonArc}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Perl Mail-to-HTML Converter"
SRC_URI="http://www.cpan.org/modules/by-authors/id/EHOOD/${MY_P}.tar.gz"
HOMEPAGE="http:/search.cpan.org/author/EHOOD/${MY_P}/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~amd64"

src_install() {
	mv ${S}/Makefile ${S}/Makefile.orig
	sed -e "s:/usr:${D}/usr:g" ${S}/Makefile.orig > ${S}/Makefile
	mv ${S}/Makefile ${S}/Makefile.tmp
	sed -e "s:${D}/usr/bin/perl:/usr/bin/perl:g" ${S}/Makefile.tmp > ${S}/Makefile

	perl-module_src_install
}
