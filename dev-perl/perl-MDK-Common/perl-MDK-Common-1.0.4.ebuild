# Copyright 2002 damien krotkine <dams@gentoo.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-MDK-Common/perl-MDK-Common-1.0.4.ebuild,v 1.3 2003/06/21 21:36:44 drobbins Exp $

inherit perl-module

S=${WORKDIR}/${PN}
DESCRIPTION="Common useful perl functions"
SRC_URI="http://www2.damz.net/files/${P}.tar.bz2"
HOMEPAGE="http://cvs.mandrakesoft.com/cgi-bin/cvsweb.cgi/soft/perl-MDK-Common/"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"
SLOT="0"

DEPEND="dev-lang/perl"
RDEPEND=$DEPEND
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}.patch || die
}

src_compile() {
 	cd ${S}
	emake || die
}
