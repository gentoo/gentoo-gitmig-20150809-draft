# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/jtag/jtag-0.5.1.ebuild,v 1.3 2004/03/27 05:26:13 dragonheart Exp $

DESCRIPTION="JTAG Tools is a software package which enables working with JTAG-aware (IEEE 1149.1) hardware devices (parts) and boards through JTAG adapter."
SRC_URI="mirror://sourceforge/openwince/${P}.tar.bz2"
HOMEPAGE="http://openwince.sourceforge.net/jtag/"
KEYWORDS="x86 sparc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
RESTRICT="nomirror"
DEPEND="dev-embedded/include
	sys-apps/gawk
	sys-apps/grep
	sys-apps/sed
	sys-devel/gcc
	sys-devel/gettext"

RDEPEND="dev-embedded/include
	virtual/glibc"


src_compile(){
	econf || die "failed to configure"
	emake || die "failed to compile"
}

src_install(){
	emake DESTDIR=${D} install || die "failed to install"
}
