# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-Lite/MIME-Lite-3.023.ebuild,v 1.2 2008/12/12 23:19:42 josejx Exp $

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="low-calorie MIME generator"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/Email-Date-Format
	dev-perl/MIME-Types
	dev-perl/MailTools"

#SRC_TEST=do
src_install(){
	perl-module_src_install
	insinto /usr/share/${PN}
	doins -r contrib || die
}
