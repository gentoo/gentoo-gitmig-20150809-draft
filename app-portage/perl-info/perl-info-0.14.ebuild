# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/perl-info/perl-info-0.14.ebuild,v 1.1 2007/02/06 10:45:29 ian Exp $

DESCRIPTION="Tool to gather relevant perl data useful for bugreports; 'emerge --info' for perl"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI="http://download.iansview.com/gentoo/tools/perl-info/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/Term-ANSIColor
	>=dev-perl/PortageXS-0.02.01"
RDEPEND="${DEPEND}"

src_install() {
	mv "${WORKDIR}"/usr "${D}"/ || die
}
