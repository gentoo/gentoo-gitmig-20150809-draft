# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/xdebug-client/xdebug-client-2.0.0_rc1.ebuild,v 1.1 2006/10/27 18:58:01 sebastian Exp $

IUSE="libedit"
DESCRIPTION="Xdebug client for the Common Debugger Protocol (DBGP)."
HOMEPAGE="http://www.xdebug.org/"
SLOT="0"
MY_PV="${PV/_/}"
SRC_URI="http://pecl.php.net/get/xdebug-${MY_PV}.tgz"
S="${WORKDIR}/xdebug-2.0.0RC1"
LICENSE="Xdebug"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND="${DEPEND} libedit? ( || ( dev-libs/libedit sys-freebsd/freebsd-lib ) )"

src_compile() {
	cd "${S}/debugclient"
	chmod +x configure

	econf \
		$(use_with libedit ) \
		|| die "Configure of debug client failed!"

	emake || die "Build of debug client failed!"
}

src_install() {
	cd "${S}/debugclient"
	newbin debugclient xdebug
}
