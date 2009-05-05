# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/texi2dvi/texi2dvi-0.ebuild,v 1.2 2009/05/05 07:20:45 fauli Exp $

DESCRIPTION="Virtual for texi2dvi (and texi2pdf)"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/texinfo
	virtual/latex-base
	|| (
		dev-texlive/texlive-texinfo
		app-text/ptex
	)"
