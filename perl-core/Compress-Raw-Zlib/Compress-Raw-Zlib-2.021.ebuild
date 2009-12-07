# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Compress-Raw-Zlib/Compress-Raw-Zlib-2.021.ebuild,v 1.6 2009/12/07 22:43:37 maekke Exp $

EAPI=2

MODULE_AUTHOR=PMQS
inherit multilib perl-module

DESCRIPTION="Low-Level Interface to zlib compression library"

SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="test"

RDEPEND=">=sys-libs/zlib-1.2.2.1"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"

src_prepare() {
	perl-module_src_prepare

	cat <<-EOF > "${S}/config.in"
		BUILD_ZLIB = False
		INCLUDE = /usr/include
		LIB = /usr/$(get_libdir)

		OLD_ZLIB = False
		GZIP_OS_CODE = AUTO_DETECT
	EOF
}
