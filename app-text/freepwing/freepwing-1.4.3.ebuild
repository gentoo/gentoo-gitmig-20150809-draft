# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/freepwing/freepwing-1.4.3.ebuild,v 1.4 2004/07/14 01:56:57 agriffis Exp $

IUSE=""

DESCRIPTION="FreePWING is a free JIS X 4081 (subset of EPWING V1) formatter"
HOMEPAGE="http://www.sra.co.jp/people/m-kasahr/freepwing/"
SRC_URI="ftp://ftp.sra.co.jp/pub/misc/freepwing/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-lang/perl"


src_install() {

	einstall perllibdir=${D}/`perl -V:sitearch | cut -d\' -f2` \
		pkgdocdir=${D}/usr/share/doc/${PF} || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
