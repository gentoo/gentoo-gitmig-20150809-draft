# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Bugzilla/WWW-Bugzilla-1.3.ebuild,v 1.9 2012/03/25 15:32:43 armin76 Exp $

EAPI=2

MODULE_AUTHOR=BMC
inherit perl-module

DESCRIPTION="WWW::Bugzilla - automate interaction with bugzilla"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-perl/WWW-Mechanize
	>=dev-perl/Params-Validate-0.88
	>=dev-perl/Crypt-SSLeay-0.57
	dev-perl/Class-MethodMaker"
DEPEND="${RDEPEND}"

src_prepare() {
	perl-module_src_prepare
	mkdir "${S}"/lib
	cp -r "${S}"/{WWW,lib}
}
