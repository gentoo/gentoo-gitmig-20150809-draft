# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoproject/autoproject-0.17.ebuild,v 1.1 2003/09/06 08:21:04 msterret Exp $

DESCRIPTION="Used to start a programming project using autoconf, automake, and optionally a command line parser generator"
SRC_URI="http://www.mv.com/ipusers/vanzandt/${P}.tar.gz"
HOMEPAGE="http://www.mv.com/ipusers/vanzandt/"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND="sys-devel/automake
	sys-devel/autoconf"

src_install() {
	einstall || die
	dodoc AUTHORS NEWS README TODO ChangeLog
}
