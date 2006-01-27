# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/generator/generator-1.3.0.13.ebuild,v 1.2 2006/01/27 02:34:17 vapier Exp $

inherit zproduct

DESCRIPTION="Widget generator package, originally designed for Archetypes"
HOMEPAGE="http://www.sourceforge.net/projects/archetypes/"
SRC_URI="mirror://sourceforge/archetypes/${PN}-1.3.0-13.tar.gz"

LICENSE="GPL-2"
SLOT="1.3"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND=">=net-zope/cmf-1.4.7"

ZPROD_LIST="generator"

src_install() {
	zproduct_src_install all
}

pkg_postinst() {
	zproduct_pkg_postinst
	ewarn "Please be warned that it should not be used together with dev-python/generator !"
}
