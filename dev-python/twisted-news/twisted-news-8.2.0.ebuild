# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-news/twisted-news-8.2.0.ebuild,v 1.6 2009/12/20 16:42:02 armin76 Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
MY_PACKAGE="News"

inherit twisted versionator

DESCRIPTION="Twisted News is an NNTP server and programming library."

KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="=dev-python/twisted-$(get_version_component_range 1-2)*
	dev-python/twisted-mail"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="twisted/news twisted/plugins"
