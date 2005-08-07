# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-MDK-Common/perl-MDK-Common-1.0.4.ebuild,v 1.9 2005/08/07 13:33:34 hansmi Exp $

inherit perl-module eutils

DESCRIPTION="Common useful perl functions"
HOMEPAGE="http://cvs.mandrakesoft.com/cgi-bin/cvsweb.cgi/soft/perl-MDK-Common/"
SRC_URI="http://www2.damz.net/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ~sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	emake || die
}
