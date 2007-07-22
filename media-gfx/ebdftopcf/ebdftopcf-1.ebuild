# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/ebdftopcf/ebdftopcf-1.ebuild,v 1.4 2007/07/22 09:51:55 dberkholz Exp $

DESCRIPTION="ebdftopcf optimially generators PCF files from BDF files"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~sh ~sparc ~x86"
IUSE=""
DEPEND=""
# these apps are used at runtime by ebdftopcf
RDEPEND="x11-apps/bdftopcf
		app-arch/gzip"

src_install() {
	insinto /usr/share/ebdftopcf
	doins Makefile.ebdftopcf
	dodoc README
}
