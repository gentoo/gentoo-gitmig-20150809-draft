# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/herdstat/herdstat-1.0.3.ebuild,v 1.5 2005/07/28 09:32:48 ka0ttic Exp $

inherit bash-completion

DESCRIPTION="Utility that parses Gentoo's herds.xml and allows queries based on herd or developer"
HOMEPAGE="http://developer.berlios.de/projects/herdstat/"
SRC_URI="http://download.berlios.de/herdstat/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc x86"
IUSE="debug"

RDEPEND="dev-libs/xmlwrapp
	net-misc/wget"
DEPEND="dev-libs/xmlwrapp
	dev-util/pkgconfig
	>=sys-apps/sed-4"

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	keepdir /var/lib/herdstat
	make DESTDIR="${D}" install || die "make install failed"
	dobashcompletion bashcomp
	dodoc AUTHORS ChangeLog README TODO NEWS
}

pkg_postinst() {
	chown root:portage /var/lib/herdstat
	chmod 0775 /var/lib/herdstat

	echo
	einfo "You must be in the portage group to use herdstat."
	bash-completion_pkg_postinst
}
