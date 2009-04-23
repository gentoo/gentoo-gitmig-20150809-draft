# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/moreutils/moreutils-0.34.ebuild,v 1.1 2009/04/23 20:07:32 patrick Exp $

EAPI="2"

inherit eutils

DESCRIPTION="a growing collection of the unix tools that nobody thought to write
thirty years ago"
HOMEPAGE="http://kitenet.net/~joey/code/moreutils/"
SRC_URI="http://ftp.de.debian.org/debian/pool/main/m/moreutils/moreutils_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/Time-Duration
	dev-perl/TimeDate"
DEPEND="${RDEPEND}
	>=app-text/docbook2X-0.8.8-r2
	app-text/docbook-xml-dtd:4.4"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.30-dtd-path.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS}" DOCBOOK2XMAN="docbook2man.pl" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" INSTALL_BIN=install install || die "install failed"
}
