# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/kazehakase/kazehakase-0.5.8.ebuild,v 1.1 2009/11/12 17:38:31 matsuu Exp $

EAPI="2"
inherit eutils flag-o-matic

IUSE="hyperestraier migemo ruby ssl webkit"

DESCRIPTION="a browser with gecko engine like Epiphany or Galeon."
SRC_URI="mirror://sourceforge.jp/${PN}/43802/${P}.tar.gz"
HOMEPAGE="http://kazehakase.sourceforge.jp/"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"

DEPEND=">=x11-libs/gtk+-2.17.7
	dev-libs/dbus-glib
	net-libs/xulrunner:1.9
	ssl? ( >=net-libs/gnutls-1.2.0 )
	ruby? ( dev-ruby/ruby-gtk2 dev-ruby/ruby-gettext )
	hyperestraier? ( >=app-text/hyperestraier-1.2 )
	webkit? ( >=net-libs/webkit-gtk-1.1.1 )"
#	coverage? ( dev-python/coverage )
#	cutter? ( >=dev-libs/cutter-1.0.6 )

RDEPEND="${DEPEND}
	migemo? ( app-text/migemo )"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_configure() {
	local myconf

	# Bug 159949
	replace-flags -Os -O2

	use ruby || myconf="${myconf} --with-ruby=no --with-rgettext=no"
	use ssl || myconf="${myconf} --disable-ssl"

	# The "e" in heyper is not a mistake, it is a typo in the source package
	econf \
		--with-gecko-engine=libxul \
		$(use_enable migemo) \
		$(use_enable hyperestraier heyper-estraier) \
		${myconf} || die
}

src_compile() {
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README* TODO*
}
