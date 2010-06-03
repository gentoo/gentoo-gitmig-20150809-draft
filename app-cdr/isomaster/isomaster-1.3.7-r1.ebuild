# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/isomaster/isomaster-1.3.7-r1.ebuild,v 1.1 2010/06/03 14:25:22 beandog Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Graphical CD image editor for reading, modifying and writing ISO images"
HOMEPAGE="http://littlesvr.ca/isomaster"
SRC_URI="http://littlesvr.ca/${PN}/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2:2
	dev-libs/iniparser"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

MYFLAGS=""

pkg_setup() {
	MYFLAGS="PREFIX=/usr"

	if ! use nls; then
		MYFLAGS="${MYFLAGS} WITHOUT_NLS=1"
		MYFLAGS="${MYFLAGS} MYDOCPATH=/usr/share/doc/${PF}/bkisofs"
		MYFLAGS="${MYFLAGS} ICONPATH=/usr/share/pixmaps/${PN}"
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-noiniparser.patch"
}

# bug 274361
src_configure() { :; }

src_compile() {
	tc-export CC
	emake ${MYFLAGS} || die "emake failed"
}

src_install() {
	emake ${MYFLAGS} DESTDIR="${D}" install || die "emake install failed"
	dodoc {CHANGELOG,CREDITS,README,TODO}.TXT
}
