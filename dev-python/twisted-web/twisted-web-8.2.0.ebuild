# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-web/twisted-web-8.2.0.ebuild,v 1.5 2009/11/28 15:15:45 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
MY_PACKAGE="Web"

inherit eutils twisted versionator

DESCRIPTION="Twisted web server, programmable in Python"

KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="soap"

DEPEND="=dev-python/twisted-$(get_version_component_range 1-2)*
	soap? ( dev-python/soappy )"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="twisted/plugins twisted/web"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-0.5.0-root-skip.patch"
	sed -e "s/test_erroneousResponse/_&/" -i twisted/web/test/test_xmlrpc.py || die "sed failed"
}
