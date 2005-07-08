# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gkismet/gkismet-0.0.10.ebuild,v 1.2 2005/07/08 09:15:54 brix Exp $

inherit eutils

DESCRIPTION="Gtk perl based client for Kismet"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gkismet.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

RDEPEND="dev-perl/gtk-perl"
DEPEND="${RDEPEND}
		sys-apps/sed"

pkg_setup() {
	if ! built_with_use dev-perl/gtk-perl gnome; then
		eerror
		eerror "${P} needs dev-perl/gtk-perl emerged with USE=\"gnome\""
		eerror
		die "${P} needs dev-perl/gtk-perl emerged with USE=\"gnome\""
	fi
}

src_unpack() {
	unpack ${P}.tar.gz

	sed -i \
		-e"s:^PREFIX=/usr/local:PREFIX=${D}/usr:" \
		-e "s:^ETC=\$(PREFIX)/etc/gkismet:ETC=${D}/etc/gkismet:" \
		${S}/Makefile

	sed -i -e "s:!PREFIX!:/usr:" ${S}/gkismet.pl

	sed -i -e "s:\$self->{'path'}{'etc'} = \$prefix . '/etc/gkismet':\$self->{'path'}{'etc'} = '/etc/gkismet':" \
		${S}/GKismetApplication.pm
}

src_install () {
	emake install || die "emake install failed"

	dodoc README Changelog
}
