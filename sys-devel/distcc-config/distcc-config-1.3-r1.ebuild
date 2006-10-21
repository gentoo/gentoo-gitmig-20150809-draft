# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/distcc-config/distcc-config-1.3-r1.ebuild,v 1.3 2006/10/21 23:02:46 vapier Exp $

DESCRIPTION="Utility to change distcc's behavior"
HOMEPAGE="http://dev.gentoo.org/~pyrania/distcc-config"
SRC_URI="http://dev.gentoo.org/~pyrania/${PN}/${PF}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~mips ~ppc ~ppc64 s390 sh ~sparc ~x86"
IUSE=""

RDEPEND="sys-apps/shadow"

src_install() {
	dobin distcc-config || die
}
