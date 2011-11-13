# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-Lite/MIME-Lite-3.28.0.ebuild,v 1.1 2011/11/13 20:23:52 tove Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=3.028
inherit perl-module

DESCRIPTION="Low-calorie MIME generator"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="dev-perl/Email-Date-Format
	>=dev-perl/MIME-Types-1.28
	dev-perl/MailTools"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do

src_install(){
	perl-module_src_install
	insinto /usr/share/${PN}
	doins -r contrib || die
}
