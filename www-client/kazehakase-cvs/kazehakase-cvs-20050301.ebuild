# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/kazehakase-cvs/kazehakase-cvs-20050301.ebuild,v 1.2 2005/03/23 16:20:05 seemant Exp $

inherit cvs

ECVS_BRANCH=""
ECVS_SERVER="cvs.sourceforge.jp:/cvsroot/kazehakase"
ECVS_USER="anonymous"
ECVS_MODULE="kazehakase"

DESCRIPTION="Kazehakase is a browser with gecko engine like Epiphany or Galeon."
SRC_URI=""
HOMEPAGE="http://kazehakase.sourceforge.jp/"
IUSE="migemo estraier thumbnail"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
LICENSE="GPL-2"

DEPEND=">=www-client/mozilla-1.7
	x11-libs/pango
	>=x11-libs/gtk+-2
	dev-util/pkgconfig
	net-misc/curl
	migemo? ( || ( app-text/migemo app-text/cmigemo ) )
	estraier? ( app-text/estraier )
	thumbnail? ( virtual/ghostscript )
	sys-devel/autoconf
	sys-devel/automake"

RDEPEND="${DEPEND}
	!net-www/kazehakase"

S="${WORKDIR}/${ECVS_MODULE}"

pkg_setup(){
	local moz_use="$(</var/db/pkg/`best_version www-client/mozilla`/USE)"

	# >=www-client/mozilla-1.7.3-r2 always depend on gtk2.
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
}

src_compile(){
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.6

	./autogen.sh || die
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
