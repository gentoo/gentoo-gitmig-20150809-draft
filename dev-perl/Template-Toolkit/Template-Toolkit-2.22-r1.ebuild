# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-Toolkit/Template-Toolkit-2.22-r1.ebuild,v 1.2 2010/12/03 02:43:44 xmw Exp $

EAPI=2

MODULE_AUTHOR=ABW
inherit perl-module

DESCRIPTION="The Template Toolkit"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-solaris"
IUSE="xml gd mysql postgres latex vim-syntax"

DEPEND="dev-perl/text-autoformat
	mysql? ( dev-perl/DBD-mysql )
	postgres? ( dev-perl/DBD-Pg )
	>=dev-perl/AppConfig-1.56"
PDEPEND="dev-perl/text-autoformat
	vim-syntax? ( app-vim/tt2-syntax )
	xml? ( dev-perl/Template-XML )
	gd? ( dev-perl/Template-GD )
	mysql? ( dev-perl/Template-DBI )
	latex? ( dev-perl/Template-Latex )
	postgres? ( dev-perl/Template-DBI )"

#The installer tries to install to /usr/local/tt2...,
#and asks for user input, so we change myconf to ensure that
# 1) make install doesn't violate the sandbox rule
# 2) perl Makefile.pl just uses reasonable defaults, and doesn't ask for input
myconf="TT_XS_ENABLE=y TT_ACCEPT=y TT_QUIET=y
	TT_DOCS=y TT_SPLASH_DOCS=y TT_EXAMPLES=y
	TT_PREFIX=${D%/}${EPREFIX}/usr/share/template-toolkit2
	TT_IMAGES=/usr/share/template-toolkit2/images"

mydoc="README"

src_unpack() {
	perl-module_src_unpack

	# uncomment these functions
	# do we really want this?
	# splash_images(); html_docs(); html_docstyle();html_examples();
	sed -i 's/^#\(splash_images\|html_\)/\1/' "${S}"/Makefile.PL || die
}
SRC_TEST=do
