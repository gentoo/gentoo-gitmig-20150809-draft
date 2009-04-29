# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-audio/gnome-audio-2.22.2.ebuild,v 1.10 2009/04/29 10:24:56 armin76 Exp $

inherit gnome2

DESCRIPTION="Gnome Desktop Sound Effects Package"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="public-domain CCPL-Attribution-ShareAlike-2.0 CCPL-Attribution-3.0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() { :; }

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
	dodoc ChangeLog README
}
