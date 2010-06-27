# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-Lite/MIME-Lite-3.027.ebuild,v 1.4 2010/06/27 19:13:20 nixnut Exp $

EAPI=2

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="low-calorie MIME generator"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE="test"

RDEPEND="dev-perl/Email-Date-Format
	>=dev-perl/MIME-Types-1.28
	dev-perl/MailTools"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do

src_install(){
	perl-module_src_install
	insinto /usr/share/${PN}
	doins -r contrib || die
}
