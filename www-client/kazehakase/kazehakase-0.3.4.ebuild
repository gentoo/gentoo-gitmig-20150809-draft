# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/kazehakase/kazehakase-0.3.4.ebuild,v 1.1 2006/01/18 17:21:14 nakano Exp $

IUSE="migemo estraier thumbnail firefox ssl"

DESCRIPTION="a browser with gecko engine like Epiphany or Galeon."
SRC_URI="mirror://sourceforge.jp/${PN}/18256/${P}.tar.gz"
HOMEPAGE="http://kazehakase.sourceforge.jp/"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"

DEPEND="!firefox? ( >=www-client/mozilla-1.7 )
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	x11-libs/pango
	>=x11-libs/gtk+-2
	dev-util/pkgconfig
	net-misc/curl
	migemo? ( || ( app-text/migemo app-text/cmigemo ) )
	estraier? ( app-text/estraier )
	thumbnail? ( virtual/ghostscript )
	ssl? ( >=net-libs/gnutls-1.2.0 )"

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
	local myconf
	if use firefox; then
		myconf="${myconf} --with-gecko-engine=firefox"
	else
		myconf="${myconf} --with-gecko-engine=mozilla"
	fi
		# myconf="${myconf} --with-gecko-engine=thunderbird"

	use ssl || myconf="${myconf} --disable-ssl"

	./autogen.sh || die
	econf `use_enable migemo` \
		${myconf} || die
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
