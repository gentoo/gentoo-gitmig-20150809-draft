# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/kazehakase/kazehakase-0.4.4.1.ebuild,v 1.1 2007/01/31 16:39:00 matsuu Exp $

IUSE="hyperestraier migemo ruby ssl"

DESCRIPTION="a browser with gecko engine like Epiphany or Galeon."
SRC_URI="mirror://sourceforge.jp/${PN}/23789/${P}.tar.gz"
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
	ruby? ( dev-ruby/ruby-gtk2 dev-ruby/ruby-gettext )
	hyperestraier? ( >=app-text/hyperestraier-1.2 )"

RDEPEND="${DEPEND}
	migemo? ( app-text/migemo )"

src_compile(){
	local myconf

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
