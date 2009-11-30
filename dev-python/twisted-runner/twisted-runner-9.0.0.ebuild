# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-runner/twisted-runner-9.0.0.ebuild,v 1.1 2009/11/30 01:34:10 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
MY_PACKAGE="Runner"

inherit twisted versionator

DESCRIPTION="Twisted Runner is a process management library and inetd replacement."

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="=dev-python/twisted-$(get_version_component_range 1)*"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

PROVIDE="virtual/inetd"

PYTHON_MODNAME="twisted/runner"
