# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-news/twisted-news-10.2.0.ebuild,v 1.5 2011/01/12 14:15:39 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
MY_PACKAGE="News"

inherit twisted versionator

DESCRIPTION="Twisted News is an NNTP server and programming library."

KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86"
IUSE=""

DEPEND="=dev-python/twisted-$(get_version_component_range 1-2)*
	=dev-python/twisted-mail-$(get_version_component_range 1-2)*"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="twisted/news twisted/plugins"
