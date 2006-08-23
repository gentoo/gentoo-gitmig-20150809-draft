# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ghostscript/ghostscript-0.ebuild,v 1.4 2006/08/23 21:27:59 swegener Exp $

DESCRIPTION="Virtual for Ghostscript"
HOMEPAGE="http://www.ghostscript.com"
SRC_URI=""
LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=""
RDEPEND="|| (
		app-text/ghostscript-gpl
		>=app-text/ghostscript-esp-8
		app-text/ghostscript-gnu
		app-text/ghostscript-esp
	)"
