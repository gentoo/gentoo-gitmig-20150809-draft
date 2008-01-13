# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/mistbot/mistbot-0.9.ebuild,v 1.6 2008/01/13 10:48:25 cla Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="A modular IRC-Bot written in C++"
HOMEPAGE="http://kuja.in/mistbot/"

SRC_URI="http://znc.in/~psychon/mistbot/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="doc xml nls debug ssl"

RDEPEND="virtual/libc
	dev-libs/confuse
	net-dns/c-ares
	xml? ( dev-libs/libxml2 )"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen
		app-text/xmlto )
	dev-util/pkgconfig"

src_compile() {
	ebegin "Change build.conf to fit needs"

	if ! use xml; then
		sed -e '/^MODS\ +=\ rss$/d' -i build.conf || die "sed failed"
	fi

	if ! use nls; then
		sed -e '/^NLS\ =\ nls$/d' -i build.conf || die "sed failed"
	fi

	if ! use debug; then
		sed -e '/^DEBUG\ =\ debug$/d' -i build.conf || die "sed failed"
	fi

	if ! use ssl; then
		sed -e '/^SSL\ =\ ssl$/d' -i build.conf || die "sed failed"
	fi

	sed -e 's/^#ONCE\ =\ yes$/ONCE\ =\ yes/' -i build.conf || die "sed failed"
	sed -re "/(PC|MOD|SCRIPT)DIR/s/lib/$(get_libdir)/" -i Makefile || die "sed failed"

	echo "CXXFLAGS=${CXXFLAGS}" >> build.conf
	echo "CXX=$(tc-getCXX)" >> build.conf
	echo "LDFLAGS=${LDFLAGS}" >> build.conf
	echo "PREFIX=/usr" >> build.conf

	ebegin "compiling source"

	emake all-oneGo || die "emake failed"

	if use doc; then
		ebegin "generate documentation"
		emake doc || die "make doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS mistbot.conf
	dosym ${P} /usr/bin/${PN}

	if use doc; then
		dodoc doc/userdoc.html
		insinto /usr/share/doc/${PF}/api
		doins doc/api/* || die "install API docs failed"
	fi
}
