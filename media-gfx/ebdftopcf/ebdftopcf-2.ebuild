# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/ebdftopcf/ebdftopcf-2.ebuild,v 1.7 2006/10/20 21:28:53 kloeri Exp $

DESCRIPTION="ebdftopcf optimially generators PCF files from BDF files"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 m68k ~mips ~ppc ~ppc-macos ~ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
# these apps are used at runtime by ebdftopcf
RDEPEND="|| ( x11-apps/bdftopcf virtual/x11 )
	app-arch/gzip"

src_install() {
	insinto /usr/share/ebdftopcf
	doins Makefile.ebdftopcf || die
	dodoc README
	doman *.5
}
