# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/perlpanel/perlpanel-0.6.0.ebuild,v 1.1 2004/07/15 14:11:50 mcummings Exp $

MY_P="PerlPanel-${PV}"
DESCRIPTION="PerlPanel is a useable, lean panel program (like Gnome's gnome-panel & KDE's Kicker) in Perl, using the Gtk2-Perl libraries."
HOMEPAGE="http://jodrell.net/projects/perlpanel"
SRC_URI="http://jodrell.net/files/${PN}/${MY_P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND=">=x11-libs/gtk+-2.4.0
	>=dev-perl/XML-Simple-2
	>=dev-perl/XML-Parser-2
	>=dev-perl/Xmms-Perl-0.12
	>=dev-perl/glib-perl-1.042
	>=dev-perl/gtk2-perl-1.042
	>=dev-perl/gnome2-wnck-0.04
	>=dev-perl/gtk2-gladexml-1.00
	>=dev-perl/Locale-gettext-1.01"

S="${WORKDIR}/${MY_P}"

src_compile() {
	make PREFIX=/usr || die
}

src_install() {
	make install PREFIX="${D}usr" || die
	dodoc COPYING ChangeLog doc/README
}
