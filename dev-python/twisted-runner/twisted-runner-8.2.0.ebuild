# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-runner/twisted-runner-8.2.0.ebuild,v 1.4 2009/12/01 09:48:55 maekke Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
MY_PACKAGE="Runner"

inherit twisted versionator

DESCRIPTION="Twisted Runner is a process management library and inetd replacement."

KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND="=dev-python/twisted-$(get_version_component_range 1)*"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

PROVIDE="virtual/inetd"

PYTHON_MODNAME="twisted/runner"
