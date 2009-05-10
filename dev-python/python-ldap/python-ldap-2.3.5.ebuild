# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ldap/python-ldap-2.3.5.ebuild,v 1.2 2009/05/10 16:15:15 ssuominen Exp $

NEED_PYTHON=2.4

inherit distutils eutils multilib

P_DOC="html-${PN}-docs-2.0.3"

DESCRIPTION="Various LDAP-related Python modules"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	doc? ( mirror://sourceforge/${PN}/${P_DOC}.tar.gz )"
HOMEPAGE="http://python-ldap.sourceforge.net/"
SLOT="0"
LICENSE="PYTHON"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc examples sasl ssl"

RDEPEND=">=net-nds/openldap-2.3
	sasl? ( dev-libs/cyrus-sasl )"
DEPEND="${DEPEND}
	dev-python/setuptools"

# Installs some script-files directly in site-packages
PYTHON_MODNAME="/"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc44.patch

	# Note: we can't add /usr/lib and /usr/lib/sasl2 to library_dirs due to a bug in py2.4
	sed -e "s:^library_dirs =.*:library_dirs =:" \
		-e "s:^include_dirs =.*:include_dirs = /usr/include /usr/include/sasl:" \
		-e "s:\(extra_compile_args =\).*:\1\nextra_link_args = -Wl,-rpath=/usr/$(get_libdir) -Wl,-rpath=/usr/$(get_libdir)/sasl2:" \
		-i setup.cfg || die "error fixing setup.cfg"

	local mylibs="ldap"
	if use sasl ; then
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
	use doc && dohtml -r "${WORKDIR}/${P_DOC/html-/}"/*
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r Demo
	fi
}
