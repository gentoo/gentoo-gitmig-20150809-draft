# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/torsmo/torsmo-0.18.ebuild,v 1.1 2004/12/27 12:43:09 dragonheart Exp $

DESCRIPTION="minimalist system monitor for X"
HOMEPAGE="http://torsmo.sourceforge.net/"
SRC_URI="mirror://sourceforge/torsmo/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""

RDEPEND="virtual/libc
	virtual/x11"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.4
	sys-devel/autoconf
	sys-apps/grep
	sys-apps/sed
	sys-devel/gcc"

src_install() {
	emake DESTDIR=${D} install || die "make install failed"
	dodoc ChangeLog AUTHORS README NEWS torsmorc.sample
}

pkg_postinst() {
	einfo 'default configuration file is "~/.torsmorc"'
	einfo "you can find a sample configuration file in"
	einfo "/usr/share/doc/${PF}/torsmorc.sample.gz"
	einfo
	einfo "Comment out temperature info lines if you have no kernel"
	einfo "support for it."
	einfo
	ewarn "Torsmo doesn't work with window managers that"
	ewarn "take control over root window such as Gnome's nautilus."
	einfo
	ewarn "Please note that >=0.18 contains mozilla support without"
	ewarn "patching, thus the mozilla USE flag has been dropped"
}
