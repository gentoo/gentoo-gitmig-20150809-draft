# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/herdstat/herdstat-1.1.0_rc2.ebuild,v 1.1 2005/04/28 17:37:49 ka0ttic Exp $

inherit bash-completion

DESCRIPTION="A multi-purpose query tool capable of things such as displaying herd/developer information and displaying category/package metadata"
HOMEPAGE="http://developer.berlios.de/projects/herdstat/"
SRC_URI="http://download.berlios.de/herdstat/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~hppa"
IUSE="debug"

RDEPEND=">=dev-cpp/libxmlpp-2.6
	net-misc/wget"
DEPEND=">=dev-cpp/libxmlpp-2.6
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
