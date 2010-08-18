# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-conch/twisted-conch-10.1.0.ebuild,v 1.2 2010/08/18 22:36:44 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
MY_PACKAGE="Conch"

inherit twisted versionator

DESCRIPTION="Twisted SSHv2 implementation"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="=dev-python/twisted-$(get_version_component_range 1-2)*
	dev-python/pyasn1
	>=dev-python/pycrypto-1.9_alpha6"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="twisted/conch twisted/plugins"
