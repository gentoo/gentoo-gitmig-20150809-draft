# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-GDOME/XML-GDOME-0.86.ebuild,v 1.20 2009/05/05 19:23:48 tove Exp $

MODULE_AUTHOR=TJMATHER
inherit perl-module

DESCRIPTION="Provides the DOM Level 2 Core API for accessing XML documents"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""

RDEPEND=">=dev-libs/gdome2-0.7.2
	dev-perl/XML-LibXML-Common
	dev-perl/XML-SAX
	>=dev-libs/glib-2.2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
