# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/luarocks/luarocks-1.0.ebuild,v 1.1 2010/11/05 22:13:24 rafaelmartins Exp $

inherit eutils

DESCRIPTION="A deployment and management system for Lua modules"
HOMEPAGE="http://www.luarocks.org"
SRC_URI="http://luaforge.net/frs/download.php/3727/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="curl openssl"

DEPEND="dev-lang/lua
		curl? ( net-misc/curl )
		openssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}
		app-arch/unzip"

src_compile() {
	USE_MD5="md5sum"
	USE_FETCH="wget"
	use openssl && USE_MD5="openssl"
	use curl && USE_FETCH="curl"

	# econf doesn't work b/c it passes variables the custom configure can't
	# handle
	./configure \
			--prefix=/usr \
			--scripts-dir=/usr/bin \
			--with-lua=/usr \
			--with-lua-lib=/usr/$(get_libdir) \
			--rocks-tree=/usr/lib/lua/luarocks \
			--with-downloader=$USE_FETCH \
			--with-md5-checker=$USE_MD5 \
			--force-config || die "configure failed"
	emake DESTDIR="${D}" || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "einstall"
}

pkg_preinst() {
	find "${D}" -type f | xargs sed -i -e "s:${D}::g" || die "sed failed"
}
