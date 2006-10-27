# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jwhois/jwhois-3.2.3-r1.ebuild,v 1.1 2006/10/27 19:35:10 drizzt Exp $

DESCRIPTION="Advanced Internet Whois client capable of recursive queries"
HOMEPAGE="http://www.gnu.org/software/jwhois/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="app-admin/eselect-whois"
DEPEND=""

src_compile() {
	econf \
		--localstatedir=/var/cache \
		--without-cache \
		$(use_enable nls) \
		|| die "econf failed"
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	einfo "Setting /usr/bin/whois symlink"
	eselect whois update --if-unset
}

pkg_postrm() {
	einfo "Updating /usr/bin/whois symlink"
	eselect whois update
}
