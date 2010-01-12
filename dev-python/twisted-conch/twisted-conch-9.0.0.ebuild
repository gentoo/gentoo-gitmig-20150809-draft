# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-conch/twisted-conch-9.0.0.ebuild,v 1.2 2010/01/12 11:36:32 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
MY_PACKAGE="Conch"

inherit twisted versionator

DESCRIPTION="Twisted SSHv2 implementation"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="=dev-python/twisted-$(get_version_component_range 1-2)*
	>=dev-python/pycrypto-1.9_alpha6"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="twisted/conch twisted/plugins"

src_prepare() {
	distutils_src_prepare
	# These tests sometimes fail with "reason 11, desc: disconnected by user".
	sed -e "s/test_extendedAttributes/_&/" -i twisted/conch/test/test_cftp.py || die "sed failed"
	sed -e "s/test_exec/_&/" -i twisted/conch/test/test_conch.py || die "sed failed"
}
