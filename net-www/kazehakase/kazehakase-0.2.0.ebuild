# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/kazehakase/kazehakase-0.2.0.ebuild,v 1.2 2004/10/14 12:29:22 nakano Exp $

inherit eutils

IUSE="migemo estraier thumbnail"

DESCRIPTION="Kazehakase is a browser with gecko engine like Epiphany or Galeon."
SRC_URI="mirror://sourceforge.jp/${PN}/11612/${P}.tar.gz"
HOMEPAGE="http://kazehakase.sourceforge.jp/"

SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
LICENSE="GPL-2"

DEPEND="net-www/mozilla
	x11-libs/pango
	>=x11-libs/gtk+-2
	dev-util/pkgconfig
	migemo? ( || ( app-text/migemo app-text/cmigemo ) )
	estraier? ( app-text/estraier )
	thumbnail? ( virtual/ghostscript )"

pkg_setup(){
	if grep -v gtk2 /var/db/pkg/net-www/mozilla-[[:digit:]]*/USE &> /dev/null
	then
		echo
		eerror
		eerror "This needs mozilla used gtk2."
		eerror "To build mozilla use gtk2, please type following command:"
		eerror
		eerror "    # USE=\"gtk2\" emerge mozilla"
		eerror
		die
	fi
}

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-label.patch
}

src_compile(){
	econf `use_enable migemo` || die
	emake || die
}

src_install(){
	emake DESTDIR="${D}" install || die
	dodoc ABOUT-NLS AUTHORS COPYING* ChangeLog NEWS README* TODO.ja
}

pkg_postinst(){
	if use thumbnail; then
		einfo "To enable thumbnail, "
		einfo "   1. Go to Preference."
		einfo "   2. Check \"Create thumbnail\"."
		einfo
		ewarn "Creating thumbnail process is still unstable (sometimes causes crash),"
		ewarn "but most causes of unstability are Mozilla. If you find a crash bug on"
		ewarn "Kazehakase, please confirm the following:"
		ewarn
		ewarn "   1. Load a crash page with Mozilla."
		ewarn "   2. Print preview the page."
		ewarn "   3. Close print preview window."
		ewarn "   4. Print the page to a file."
		ewarn
	fi
}
