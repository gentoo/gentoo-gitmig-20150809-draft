# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/moreutils/moreutils-0.45.ebuild,v 1.1 2011/06/22 17:47:35 radhermit Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="a growing collection of the unix tools that nobody thought to write
thirty years ago"
HOMEPAGE="http://kitenet.net/~joey/code/moreutils/"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="+doc +perl"

RDEPEND="
	perl? (
		dev-lang/perl
		dev-perl/IPC-Run
		dev-perl/Time-Duration
		dev-perl/TimeDate
	)"
DEPEND="
	doc? (
		dev-lang/perl
		>=app-text/docbook2X-0.8.8-r2
		app-text/docbook-xml-dtd:4.4
	)"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.42-dtd-path.patch

	# Don't build manpages
	if ! use doc ; then
		sed -i -e '/^all:/s/$(MANS)//' \
			-e '/man1/d' \
			Makefile
	fi

	# Don't install perl scripts
	if ! use perl ; then
		sed -i -e '/PERLSCRIPTS/d' Makefile
	fi
}

src_compile() {
	tc-export CC
	emake CFLAGS="${CFLAGS}" DOCBOOK2XMAN=docbook2man.pl
}

src_install() {
	emake DESTDIR="${D}" INSTALL_BIN=install install
}
