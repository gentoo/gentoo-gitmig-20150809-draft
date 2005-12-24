# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libungif/libungif-9999.ebuild,v 1.1 2005/12/24 01:45:37 carlo Exp $

inherit eutils libtool

DESCRIPTION="A library for reading and writing gif images without LZW compression"
HOMEPAGE="http://sourceforge.net/projects/libungif/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc ppc-macos sparc x86"
IUSE="X"

pkg_setup() {
	echo
	eerror "This package is deprecated. Please do"
	eerror "emerge -C libungif && emerge giflib && revdep-rebuild"
	die
}
