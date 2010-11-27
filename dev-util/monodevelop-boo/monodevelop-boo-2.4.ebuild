# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop-boo/monodevelop-boo-2.4.ebuild,v 1.4 2010/11/27 16:08:58 loki_val Exp $

EAPI=2

inherit mono multilib versionator

DESCRIPTION="Boo Extension for MonoDevelop"
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://ftp.novell.com/pub/mono/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND=">=dev-lang/mono-2.4
	=dev-util/monodevelop-$(get_version_component_range 1-2)*
	>=dev-lang/boo-0.8.2.2960"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.23"

src_configure() {
	MD_BOO_CONFIG=""
	if use debug; then
		MD_BOO_CONFIG="--config=DEBUG"
	else
		MD_BOO_CONFIG="--config=RELEASE"
	fi

	./configure \
		--prefix=/usr		\
		${MD_BOO_CONFIG}	\
	|| die "configure failed"
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "install failed"
	mono_multilib_comply
}
