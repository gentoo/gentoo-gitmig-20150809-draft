# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/mistbot/mistbot-0.9.ebuild,v 1.2 2007/10/30 21:02:32 cla Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A modular IRC-Bot written in C++"
HOMEPAGE="http://kuja.in/mistbot/"

SRC_URI="http://znc.in/~psychon/mistbot/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc xml nls debug ssl"

RDEPEND="virtual/libc
	dev-libs/confuse
	net-dns/c-ares
	xml? ( dev-libs/libxml2 )"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen
		app-text/xmlto )"

src_compile() {
	ebegin "Change build.conf to fit needs"

	if ! use xml; then
		sed -e '/^MODS\ +=\ rss$/d' -i build.conf || die "sed failed"
	fi

	if ! use nls; then
		sed -e '/^NLS\ =\nls$/d' -i build.conf || die "sed failed"
	fi

	if ! use debug; then
		sed -e '/^DEBUG\ =\ debug$/d' -i build.conf || die "sed failed"
	fi

	if ! use ssl; then
		sed -e '/^SSL\ =\ ssl$/d' -i build.conf || die "sed failed"
	fi

	sed -e 's/^#ONCE\ =\ yes$/ONCE\ =\ yes/' -i build.conf || die "sed failed"

	echo "CXXFLAGS=${CXXFLAGS}" >> build.conf
	echo "CXX=$(tc-getCXX)" >> build.conf
	echo "PREFIX=/usr" >> build.conf

	ebegin "compiling source"

	emake all-oneGo || die "emake failed"

	if use doc; then
		ebegin "generate documentation"
		#make doc || die "make doc failed"
		emake doc || die "make doc failed"
	fi
}

src_install() {
	#make install DESTDIR="${D}" || die "make install failed"
	emake DESTDIR="${D}" install
	dodoc AUTHORS mistbot.conf

	if use doc; then
		dodoc doc/userdoc.html
		insinto /usr/share/doc/${PF}/api
		doins doc/api/* || die "install API docs failed"
	fi
}
