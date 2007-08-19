# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/po4a/po4a-0.32.ebuild,v 1.2 2007/08/19 19:58:59 jer Exp $

inherit eutils perl-app

DESCRIPTION="Tools for helping translation of documentation"
HOMEPAGE="http://po4a.alioth.debian.org"
SRC_URI="http://alioth.debian.org/frs/download.php/2108/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/SGMLSpm
	>=sys-devel/gettext-0.13
	app-text/openjade
	dev-perl/Locale-gettext
	dev-perl/TermReadKey
	dev-perl/Text-WrapI18N
	dev-lang/perl"
DEPEND=">=dev-perl/module-build-0.28
	${RDEPEND}"

SRC_TEST="do"

src_compile() {
	rm "${S}"/Makefile
	perl-app_src_compile
}
