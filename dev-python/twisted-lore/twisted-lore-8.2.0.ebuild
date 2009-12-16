# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-lore/twisted-lore-8.2.0.ebuild,v 1.6 2009/12/16 00:37:21 ranger Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
MY_PACKAGE="Lore"

inherit twisted versionator

DESCRIPTION="Twisted documentation system"

KEYWORDS="~alpha amd64 ~ia64 ppc ppc64 ~sparc x86"
IUSE=""

DEPEND="=dev-python/twisted-$(get_version_component_range 1-2)*
	dev-python/twisted-web"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="twisted/lore twisted/plugins"
