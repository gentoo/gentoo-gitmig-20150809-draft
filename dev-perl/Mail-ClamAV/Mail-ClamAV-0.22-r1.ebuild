# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-ClamAV/Mail-ClamAV-0.22-r1.ebuild,v 1.2 2008/09/20 16:07:04 maekke Exp $

MODULE_AUTHOR=SABECK
inherit perl-module eutils

DESCRIPTION="Perl extension for the clamav virus scanner."

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~sparc x86"
IUSE=""

DEPEND=">=app-antivirus/clamav-0.94
	dev-perl/Inline
	dev-lang/perl"

PATCHES=( "${FILESDIR}"/0.22-clamav-0.94.patch )
SRC_TEST=do

src_install() {
	perl-module_src_install
	dodoc README || die
}
