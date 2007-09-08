# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_whatkilledus/mod_whatkilledus-0.0.1.ebuild,v 1.1 2007/09/08 17:04:32 hollow Exp $

inherit apache-module eutils toolchain-funcs

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Apache2 modules to debug segmentation faults in threads"
HOMEPAGE="http://people.apache.org/~trawick/exception_hook.html"
SRC_URI="mirror://gentoo/${P}.c"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="WHATKILLEDUS"

need_apache2

src_unpack() {
	mkdir -p "${S}" || die "mkdir S failed"
	cp -f "${DISTDIR}/${P}.c" "${S}/${PN}.c" || die "source copy failed"
}

src_compile() {
	$(tc-getCC) \
		$($(apr_config) --includes) \
		$($(apr_config) --cppflags) \
		-o "${S}"/gen_test_char \
		"${FILESDIR}"/gen_test_char.c
	"${S}"/gen_test_char > "${S}"/test_char.h
	apache-module_src_compile
}
