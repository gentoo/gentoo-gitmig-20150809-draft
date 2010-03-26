# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ttf-fonts/ttf-fonts-1.ebuild,v 1.2 2010/03/26 14:26:13 spatz Exp $

DESCRIPTION="Virtual for TTF fonts"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="|| (
		media-fonts/dejavu
		media-fonts/ttf-bitstream-vera
		media-fonts/freefont-ttf
	)"
