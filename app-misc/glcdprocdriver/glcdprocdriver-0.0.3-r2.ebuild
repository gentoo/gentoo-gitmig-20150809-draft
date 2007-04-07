# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/glcdprocdriver/glcdprocdriver-0.0.3-r2.ebuild,v 1.1 2007/04/07 19:48:27 rbu Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="Glue library for the glcdlib LCDproc driver based on GraphLCD"
HOMEPAGE="http://www.muresan.de/graphlcd/lcdproc"
SRC_URI="http://www.muresan.de/graphlcd/lcdproc/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"

S=${WORKDIR}/${P}

DEPEND=">=app-misc/graphlcd-base-0.1.3"
RDEPEND=${DEPEND}

IUSE=""

src_unpack()
{
	unpack ${A}
	cd "${S}"

	# use CFLAGS defined in /etc/make.conf instead of the ones in Make.config
	sed -i ${S}/Make.config -e "s:FLAGS *=:FLAGS ?=:"
	sed -i ${S}/Make.config -e "6s:gcc:$(tc-getCC):"
	sed -i ${S}/Make.config -e "9s:g++:$(tc-getCXX):"
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_install()
{
	emake DESTDIR=${D}/usr LIBDIR=${D}/usr/$(get_libdir) install || die "make install failed"
	dodoc AUTHORS README INSTALL TODO ChangeLog
}
