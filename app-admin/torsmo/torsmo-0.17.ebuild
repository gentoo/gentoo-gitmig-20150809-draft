# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/torsmo/torsmo-0.17.ebuild,v 1.10 2004/10/19 22:00:17 bazik Exp $

inherit eutils

DESCRIPTION="system monitor that sits in the corner of your desktop"
HOMEPAGE="http://torsmo.sourceforge.net/"
SRC_URI="mirror://sourceforge/torsmo/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc amd64 sparc"
IUSE="mozilla"

RDEPEND="virtual/libc
	virtual/x11"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.4
	sys-devel/autoconf
	sys-apps/grep
	sys-apps/sed
	sys-devel/gcc"

src_unpack() {
	unpack ${A}
	cd ${S}
	use mozilla && epatch ${FILESDIR}/${P}-mozilla.patch
}

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
	ewarn "May not work on KDE until you exit (and then only breifly)"
	ewarn "for the above reason."
}
