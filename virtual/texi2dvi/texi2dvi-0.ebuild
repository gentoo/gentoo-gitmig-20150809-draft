# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/texi2dvi/texi2dvi-0.ebuild,v 1.4 2011/08/28 13:18:35 grobian Exp $

DESCRIPTION="Virtual for texi2dvi (and texi2pdf)"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/texinfo
	virtual/latex-base
	|| (
		dev-texlive/texlive-texinfo
		app-text/ptex
	)"
