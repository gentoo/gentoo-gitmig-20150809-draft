# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-audio/gnome-audio-2.22.1.ebuild,v 1.6 2008/04/29 09:09:25 armin76 Exp $

inherit gnome2

DESCRIPTION="Gnome Desktop Sound Effects Package"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="public-domain CCPL-Attribution-ShareAlike-2.0 CCPL-Attribution-3.0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() { :; }

src_install() {
	make DESTDIR="${D}" install || die "installation failed"
	dodoc ChangeLog README
}
