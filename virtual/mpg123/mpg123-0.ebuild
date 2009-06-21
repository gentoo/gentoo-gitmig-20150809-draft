# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/mpg123/mpg123-0.ebuild,v 1.4 2009/06/21 07:38:18 ssuominen Exp $

EAPI=2

DESCRIPTION="Virtual for command-line players mpg123 and mpg321"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( media-sound/mpg123
	>media-sound/mpg321-0.2.10-r3[symlink] )"
DEPEND="${RDEPEND}
	!<media-sound/mpg321-0.2.10-r4
	!<media-sound/mpg123-1.7.3-r1"
