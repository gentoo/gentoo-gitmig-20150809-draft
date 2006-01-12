# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/ebdftopcf/ebdftopcf-1.ebuild,v 1.1 2006/01/12 01:50:21 robbat2 Exp $

DESCRIPTION="ebdftopcf optimially generators PCF files from BDF files"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc ~ppc64 ~mips ~alpha ~ia64"
IUSE=""
DEPEND=""
# these apps are used at runtime by ebdftopcf
RDEPEND="|| ( x11-apps/bdftopcf virtual/x11 )
		app-arch/gzip"

src_install() {
	insinto /usr/share/ebdftopcf
	doins Makefile.ebdftopcf
	dodoc README
}
