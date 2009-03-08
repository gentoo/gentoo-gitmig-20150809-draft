# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/smooth-themes/smooth-themes-0.5.8-r1.ebuild,v 1.11 2009/03/08 02:57:44 solar Exp $

WANT_AUTOMAKE=1.8
inherit autotools eutils

DESCRIPTION="A clean set of GTK+ themes based on the Smooth engine"
HOMEPAGE="http://sourceforge.net/projects/smooth-engine/"
SRC_URI="mirror://sourceforge/smooth-engine/${P}.tar.gz"

KEYWORDS="~arm amd64 ppc sparc x86"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=">=x11-themes/gtk-engines-2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Remove unnecessary checks in the configure script
	epatch "${FILESDIR}"/${P}-remove_checks.patch

	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog NEWS README
}
