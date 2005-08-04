# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/viewglob/viewglob-2.0.3.ebuild,v 1.2 2005/08/04 20:20:19 slarti Exp $

inherit eutils

DESCRIPTION="Graphical display of directories and globs referenced at the shell prompt"
HOMEPAGE="http://viewglob.sourceforge.net/"
SRC_URI="mirror://sourceforge/viewglob/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc"
IUSE=""

DEPEND=">=dev-libs/glib-2.2.0
	>=x11-libs/gtk+-2.4.0
	|| ( app-shells/bash app-shells/zsh )"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS COPYING COPYING2 ChangeLog HACKING INSTALL NEWS README TODO
}

pkg_postinst() {
	einfo " "
	einfo "/usr/bin/viewglob is a wrapper for vgd and vgseer (client and"
	einfo "daemon, respectively). Generally speaking, this is what you want to"
	einfo "execute from your shell."
	einfo " "
	einfo "Should you prefer to start viewglob with each shell session, try"
	einfo "something like this:"
	einfo " "
	einfo '  if [[ ! $VG_VIEWGLOB_ACTIVE && $DISPLAY ]] ; then'
	einfo '      exec viewglob'
	einfo '  fi'
	einfo " "
	einfo "Have a look at http://viewglob.sourceforge.net/faq.html for a"
	einfo "few more viewglob tricks."
	ewarn " "
	ewarn "There are some known bugs in viewglob with screen. Exercise some"
	ewarn "caution and take results with a pinch of salt if you try the two"
	ewarn "together."
	ewarn " "
}
