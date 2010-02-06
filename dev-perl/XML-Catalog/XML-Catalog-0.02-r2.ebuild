# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Catalog/XML-Catalog-0.02-r2.ebuild,v 1.16 2010/02/06 13:39:54 tove Exp $

EAPI=2

MODULE_AUTHOR=EBOHLMAN
inherit perl-module

DESCRIPTION="Resolve public identifiers and remap system identifiers"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

RDEPEND=">=dev-perl/XML-Parser-2.29
	>=dev-perl/libwww-perl-5.48"
DEPEND="${RDEPEND}"
