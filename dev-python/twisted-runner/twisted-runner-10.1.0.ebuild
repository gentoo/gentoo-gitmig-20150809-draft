# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-runner/twisted-runner-10.1.0.ebuild,v 1.1 2010/07/09 21:22:44 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
MY_PACKAGE="Runner"

inherit twisted versionator

DESCRIPTION="Twisted Runner is a process management library and inetd replacement."

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="=dev-python/twisted-$(get_version_component_range 1)*"
RDEPEND="${DEPEND}"

PROVIDE="virtual/inetd"

PYTHON_MODNAME="twisted/runner"
