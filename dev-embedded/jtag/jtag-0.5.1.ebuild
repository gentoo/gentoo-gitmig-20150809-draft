# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/jtag/jtag-0.5.1.ebuild,v 1.5 2004/06/29 13:25:12 vapier Exp $

DESCRIPTION="software package for working with JTAG-aware (IEEE 1149.1) hardware devices (parts) and boards through JTAG adapter"
HOMEPAGE="http://openwince.sourceforge.net/jtag/"
SRC_URI="mirror://sourceforge/openwince/${P}.tar.bz2"

KEYWORDS="x86 sparc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="dev-embedded/include
	sys-apps/gawk
	sys-apps/grep
	sys-apps/sed
	sys-devel/gcc
	sys-devel/gettext"
RDEPEND="dev-embedded/include
	virtual/libc"

src_install() {
	emake DESTDIR=${D} install || die "failed to install"
}
