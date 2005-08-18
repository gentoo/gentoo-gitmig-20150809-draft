# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/kazehakase/kazehakase-0.2.7.ebuild,v 1.4 2005/08/18 18:49:11 hansmi Exp $

IUSE="migemo estraier thumbnail firefox"

DESCRIPTION="a browser with gecko engine like Epiphany or Galeon."
SRC_URI="mirror://sourceforge.jp/${PN}/14508/${P}.tar.gz"
HOMEPAGE="http://kazehakase.sourceforge.jp/"

SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
LICENSE="GPL-2"

DEPEND="!firefox? ( >=www-client/mozilla-1.7 )
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	x11-libs/pango
	>=x11-libs/gtk+-2
	dev-util/pkgconfig
	net-misc/curl
	migemo? ( || ( app-text/migemo app-text/cmigemo ) )
	estraier? ( app-text/estraier )
	thumbnail? ( virtual/ghostscript )"

pkg_setup(){
	if ! use firefox; then
		local moz_use="$(</var/db/pkg/`best_version www-client/mozilla`/USE)"
		if ! has_version '>=www-client/mozilla-1.7.3-r2' && ! has gtk2 ${moz_use}
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
	fi
}

src_compile(){
	if use firefox; then
		geckoengine="firefox"
	else
		geckoengine="mozilla"
	fi
	econf `use_enable migemo` --with-gecko-engine=${geckoengine} || die
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
