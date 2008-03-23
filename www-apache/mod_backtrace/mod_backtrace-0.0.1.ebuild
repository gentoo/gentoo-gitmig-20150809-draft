# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_backtrace/mod_backtrace-0.0.1.ebuild,v 1.3 2008/03/23 12:05:53 hollow Exp $

inherit apache-module eutils confutils

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
APACHE2_MOD_DEFINE="BACKTRACE"

need_apache2

pkg_setup() {
	confutils_require_built_with_all www-servers/apache debug
}

src_unpack() {
	mkdir -p "${S}" || die "mkdir S failed"
	cp -f "${DISTDIR}/${P}.c" "${S}/${PN}.c" || die "source copy failed"
}
