# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodoc/monodoc-1.2.5.ebuild,v 1.1 2007/09/10 19:48:18 jurek Exp $

inherit mono multilib

DESCRIPTION="Documentation for mono's .Net class library"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="X"

RDEPEND=">=dev-lang/mono-1.1
		www-client/lynx"
DEPEND="${RDEPEND}
		app-arch/unzip"
PDEPEND="X? ( >=dev-util/mono-tools-1.1.17 )"

RESTRICT="test"

# Parallel build unfriendly
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Install all our .dlls under $(libdir), not $(prefix)/lib
	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e 's:$(prefix)/lib:$(libdir):'             \
			${S}/engine/Makefile.am                        \
		|| die "sed failed"

		sed -i -e 's:libdir=@prefix@/lib:libdir=@libdir@:' \
			-i -e 's:${prefix}/lib:${libdir}:'             \
			${S}/monodoc.pc.in                             \
		|| die "sed failed"

		aclocal || die "aclocal failed"
		automake || die "automake failed"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die
}
