# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/stklos/stklos-0.98.ebuild,v 1.2 2010/10/06 03:15:06 chiiph Exp $

EAPI="3"

inherit eutils

DESCRIPTION="fast and light Scheme implementation"
HOMEPAGE="http://www.stklos.net"
SRC_URI="http://www.stklos.org/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="threads ldap gtk gnome"
DEPEND="dev-libs/gmp
	dev-libs/libpcre
	dev-libs/boehm-gc[threads]
	ldap? ( net-nds/openldap )
	gtk? ( x11-libs/gtk+ )"
#		gnome? ( )" # someone using gnome should figure out what package will enable gnome support
#silex and ``The Dominique Boucher LALR Package'' may also be deps, not in tree though
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-ldflags.patch
}

src_configure() {
#anyone interested in lurc threads? not in tree though
#disable ffi while only bundled can be used
	econf $(use_enable threads threads pthreads) $(use_enable ldap) $(use_enable gtk) $(use_enable gnome) \
		--without-gmp-light --without-provided-gc --without-provided-regexp --disable-ffi
}

# call/cc & dynamic-wind test fails on amd64. already upstream
