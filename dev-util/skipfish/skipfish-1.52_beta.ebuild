# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/skipfish/skipfish-1.52_beta.ebuild,v 1.1 2010/07/29 11:16:07 ssuominen Exp $

EAPI=2
inherit toolchain-funcs

MY_P=${P/_beta/b}

DESCRIPTION="A fully automated, active web application security reconnaissance tool"
HOMEPAGE="http://code.google.com/p/skipfish/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tgz"

LICENSE="Apache-2.0 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-libs/openssl
	net-dns/libidn
	sys-libs/zlib"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i \
		-e '/CFLAGS_GEN/s:-g -ggdb::' \
		-e '/CFLAGS_OPT/s:-O3::' \
		Makefile || die

	sed -i \
		-e "/ASSETS_DIR/s:assets:/usr/share/doc/${PF}/html:" \
		config.h || die
}

src_compile() {
	tc-export CC

	local _debug
	use debug && _debug=debug

	emake ${_debug} || die
}

src_install() {
	dobin ${PN} || die
	doman ${PN}.1 || die

	insinto /usr/share/${PN}/dictionaries
	doins dictionaries/*.wl || die

	dohtml assets/* || die

	dodoc ChangeLog dictionaries/README-FIRST README
}
