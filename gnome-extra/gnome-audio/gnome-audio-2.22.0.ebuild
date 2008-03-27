# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-audio/gnome-audio-2.22.0.ebuild,v 1.1 2008/03/27 22:43:24 eva Exp $

inherit gnome2

DESCRIPTION="Gnome Desktop Sound Effects Package"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="public-domain CCPL-Attribution-ShareAlike-2.0 CCPL-Attribution-3.0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() { :; }


src_install() {
	# emake fails probably because files aren't were they are supposed too
	# when it comes to the ln commands
	make datadir="${D}/usr/share" install || die "installed failed"
	dodoc README
}
