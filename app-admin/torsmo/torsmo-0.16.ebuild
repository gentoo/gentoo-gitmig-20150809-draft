# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/torsmo/torsmo-0.16.ebuild,v 1.1 2004/05/14 21:03:57 dragonheart Exp $

DESCRIPTION="Torsmo is a system monitor that sits in the corner of your desktop."
HOMEPAGE="http://torsmo.sourceforge.net/"
SRC_URI="mirror://sourceforge/torsmo/${P}.tar.gz"
RESTRICT="nomirror"
IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc"

RDEPEND="virtual/glibc
	virtual/x11"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.4
	sys-devel/autoconf
	sys-apps/grep
	sys-apps/sed
	sys-devel/gcc"

src_compile() {
	econf || die "Configure died"
	emake || die "make died"
}

src_install() {
	emake DESTDIR=${D} install || die "make install failed"
	dodoc ChangeLog AUTHORS README NEWS COPYING torsmorc.sample
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
	ewarn "May not work on KDE until you exit (and then only breifly)"
	ewarn "for the above reason."
}
