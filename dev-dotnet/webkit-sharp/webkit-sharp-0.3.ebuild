# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/webkit-sharp/webkit-sharp-0.3.ebuild,v 1.6 2011/04/12 07:27:40 pacho Exp $

EAPI=2

inherit mono multilib

DESCRIPTION="WebKit-gtk bindings for Mono"
HOMEPAGE="http://www.mono-project.com/"
SRC_URI="http://mono.ximian.com/monobuild/preview/sources/webkit-sharp/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=dev-lang/mono-2
	=net-libs/webkit-gtk-1.2*:2
	dev-dotnet/gtk-sharp:2"

RDEPEND="${DEPEND}"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	if [[ -h /usr/$(get_libdir)/libwebkit-1.0.so.2 ]]
	then
		ebegin "Adjusting .dll.config to point to the right .so"
		sed -i \
			-e 's:@LIB_PREFIX@.1@LIB_SUFFIX@:@LIB_PREFIX@.2@LIB_SUFFIX@:' \
			sources/webkit-sharp.dll.config.in || die "Sed failed"
		eend $?
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README ChangeLog || die
	mono_multilib_comply
}
