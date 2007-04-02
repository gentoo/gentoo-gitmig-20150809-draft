# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/glcdprocdriver/glcdprocdriver-0.0.3-r1.ebuild,v 1.1 2007/04/02 13:34:42 rbu Exp $

inherit eutils flag-o-matic multilib

DESCRIPTION="Glue library for the glcdlib LCDproc driver based on GraphLCD"
HOMEPAGE="http://www.muresan.de/graphlcd/lcdproc"
SRC_URI="http://www.muresan.de/graphlcd/lcdproc/${P}.tar.bz2"

KEYWORDS="~x86 ~amd64"
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
}

src_compile()
{
	append-flags -fPIC

	emake || die "make failed"
}

src_install()
{
	emake DESTDIR=${D}/usr LIBDIR=${D}/usr/$(get_libdir) install || die "make install failed"
	dodoc AUTHORS README INSTALL TODO ChangeLog
}
