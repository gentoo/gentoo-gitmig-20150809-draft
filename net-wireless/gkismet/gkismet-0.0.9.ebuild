# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gkismet/gkismet-0.0.9.ebuild,v 1.1 2004/11/26 16:28:54 brix Exp $

DESCRIPTION="Gtk perl based Kismet client"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gkismet.sourceforge.net"
KEYWORDS="~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="dev-perl/gtk-perl
		=net-wireless/kismet-2004.10.1*
		sys-apps/sed"

src_unpack() {
	unpack ${P}.tar.gz

	# install to /usr
	sed -i "s:^PREFIX=/usr/local:PREFIX=${D}/usr:" ${S}/Makefile

	# install config files to /etc
	sed -i "s:^ETC=\$(PREFIX)/etc/gkismet:ETC=${D}/etc/gkismet:" \
		${S}/Makefile

	# set correct prefix
	sed -i "s:!PREFIX!:/usr:" ${S}/gkismet.pl

	# config files are now in /etc/gkismet
	sed -i "s:\$self->{'path'}{'etc'} = \$prefix . '/etc/gkismet':\$self->{'path'}{'etc'} = '/etc/gkismet':" \
		${S}/GKismetApplication.pm
}

src_install () {
	emake install || die

	dodoc README Changelog
}

pkg_postinst() {
	einfo ""
	einfo "If ${PN} complains about not finding Gnome.pm, remerge"
	einfo "dev-perl/gtk-perl with USE=gnome"
	einfo ""
}
