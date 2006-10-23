# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jumpgate/jumpgate-0.7.ebuild,v 1.8 2006/10/23 11:38:55 avenj Exp $

inherit eutils toolchain-funcs

DESCRIPTION="An advanced TCP connection forwarder."
HOMEPAGE="http://jumpgate.sourceforge.net"
SRC_URI="http://jumpgate.sourceforge.net/${P}.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	if [ "$(gcc-major-version)" == "4" ] ; then
		sed -i -e '/^AC_CHECK_TYPE/d' configure.in
		autoconf || die "autoconf failed"
	fi
}

src_install() {
	make install install_prefix=${D} || die
	dodoc README ChangeLog
}
