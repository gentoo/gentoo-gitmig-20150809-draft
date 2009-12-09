# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ldap/python-ldap-2.3.10.ebuild,v 1.4 2009/12/09 18:51:21 nixnut Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils multilib

DOC_P="${PN}-docs-html-2.3.7"

DESCRIPTION="Various LDAP-related Python modules"
SRC_URI="http://pypi.python.org/packages/source/p/python-ldap/${P}.tar.gz
	doc? ( http://www.python-ldap.org/doc/${DOC_P}.tar.gz )"
HOMEPAGE="http://python-ldap.sourceforge.net/ http://pypi.python.org/pypi/python-ldap"

SLOT="0"
LICENSE="PYTHON"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ppc ~ppc64 ~sparc ~x86"
IUSE="doc examples sasl ssl"

RDEPEND=">=net-nds/openldap-2.4
	sasl? ( dev-libs/cyrus-sasl )"
DEPEND="${DEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CHANGES README"

src_prepare() {
	# Note: we can't add /usr/lib and /usr/lib/sasl2 to library_dirs due to a bug in py2.4
	sed -e "s:^library_dirs =.*:library_dirs =:" \
		-e "s:^include_dirs =.*:include_dirs = /usr/include /usr/include/sasl:" \
		-e "s:\(extra_compile_args =\).*:\1\nextra_link_args = -Wl,-rpath=/usr/$(get_libdir) -Wl,-rpath=/usr/$(get_libdir)/sasl2:" \
		-i setup.cfg || die "error fixing setup.cfg"

	local mylibs="ldap"
	if use sasl; then
		use ssl && mylibs="ldap_r"
		mylibs="${mylibs} sasl2"
	fi
	use ssl && mylibs="${mylibs} ssl crypto"

	sed -e "s:^libs = .*:libs = lber resolv ${mylibs}:" \
		-e "s:^compile.*:compile = 0:" \
		-e "s:^optimize.*:optimize = 0:" \
		-i setup.cfg || die "error setting up libs in setup.cfg"
}

src_install() {
	distutils_src_install

	use doc && dohtml -r "${WORKDIR}/${DOC_P}"/*
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r Demo
	fi
}

pkg_postinst() {
	python_mod_optimize dsml.py ldapurl.py ldif.py ldap
}

pkg_postrm() {
	python_mod_cleanup
}
