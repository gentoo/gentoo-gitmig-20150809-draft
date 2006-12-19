# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodoc/monodoc-1.1.10.ebuild,v 1.7 2006/12/19 20:15:57 jurek Exp $

inherit mono multilib

DESCRIPTION="Documentation for mono's .Net class library"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="www-client/lynx"

DEPEND="${RDEPEND}
		>=dev-lang/mono-1.1"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Install all our .dlls under $(libdir), not $(prefix)/lib
	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e 's:$(prefix)/lib:$(libdir):' \
			${S}/engine/Makefile.am || die "sed failed"
		sed -i -e 's:libdir=@prefix@/lib:libdir=@libdir@:' \
				-e 's:${prefix}/lib:${libdir}:' \
			${S}/monodoc.pc.in || die "sed failed"

		aclocal || die "aclocal failed"
		automake || die "automake failed"
	fi
}

src_compile() {
	econf || die
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	einfo
	einfo "monodoc's GUI documentation browser has been seperated out into a"
	einfo "seperate package. If you want the browser, please emerge mono-tools."
	einfo
}
