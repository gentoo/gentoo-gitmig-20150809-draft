# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/io/io-2006.12.07.ebuild,v 1.1 2006/12/09 02:39:42 araujo Exp $

inherit versionator

MY_PV=$(replace_all_version_separators "-")
MY_P="Io-${MY_PV}"

DESCRIPTION="Io is a small, prototype-based programming language."
HOMEPAGE="http://www.iolanguage.com"
SRC_URI="http://io.urbanape.com/release/${MY_P}.tar.gz
	http://www.sigusr1.org/~steve/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"
DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	make INSTALL_PREFIX="/usr" || die "make failed."
}

src_install() {
	make install \
		INSTALL_PREFIX="${D}/usr" \
		|| die "make install failed"
	if use doc; then
		dodoc ${S}/docs/guide.{html,pdf}
	fi
}
