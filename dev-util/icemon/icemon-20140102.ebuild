# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/icemon/icemon-20140102.ebuild,v 1.2 2014/01/02 13:13:10 scarabeus Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Icemon is a KDE monitor program for use with Icecream compile clusters."
HOMEPAGE="http://www.opensuse.org/icecream"
SRC_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${DEPEND}
	sys-devel/icecream
"
