# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/kazehakase/kazehakase-0.4.3.ebuild,v 1.1 2006/12/02 08:02:48 matsuu Exp $

IUSE="hyperestraier migemo ruby ssl thumbnail"

DESCRIPTION="a browser with gecko engine like Epiphany or Galeon."
SRC_URI="mirror://sourceforge.jp/${PN}/22887/${P}.tar.gz"
HOMEPAGE="http://kazehakase.sourceforge.jp/"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"

DEPEND="|| ( >=www-client/mozilla-firefox-1.0.2-r1
		>=www-client/seamonkey-1.0
		>=mail-client/mozilla-thunderbird-0.8
		>=net-libs/xulrunner-1.8 )
	>=x11-libs/gtk+-2.6
	ssl? ( >=net-libs/gnutls-1.2.0 )
	ruby? ( dev-ruby/ruby-gtk2 dev-ruby/ruby-gettext )"

RDEPEND="${DEPEND}
	hyperestraier? ( >=app-text/hyperestraier-1.2 )
	migemo? ( || ( app-text/migemo app-text/cmigemo ) )
	thumbnail? ( || ( virtual/ghostscript
		>=www-client/mozilla-firefox-2.0_beta1 ) )"

src_compile(){
	local myconf

	if use hyperestraier; then
		myconf="${myconf} --with-search-engine=hyperestraier"
	else
		myconf="${myconf} --without-search-engine"
	fi

	myconf="${myconf} $(use_enable migemo)"
	use ruby || myconf="${myconf} --with-ruby=no --with-rgettext=no"
	use ssl || myconf="${myconf} --disable-ssl"

	econf ${myconf} || die
	emake || die
}

src_install(){
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README* TODO*
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
