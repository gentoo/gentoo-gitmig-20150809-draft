# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/smooth-themes/smooth-themes-0.5.8-r1.ebuild,v 1.5 2006/02/17 22:21:44 fuzzyray Exp $

inherit eutils

DESCRIPTION="A clean set of GTK+ themes based on the Smooth engine"
HOMEPAGE="http://sourceforge.net/projects/smooth-engine/"
SRC_URI="mirror://sourceforge/smooth-engine/${P}.tar.gz"

KEYWORDS="ppc sparc x86"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=">=x11-themes/gtk-engines-2"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Remove unnecessary checks in the configure script
	epatch ${FILESDIR}/${P}-remove_checks.patch

	export WANT_AUTOMAKE=1.8
	aclocal  || die "aclocal failed"
	autoconf || die "autoconf failed"
	automake || die "automake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog NEWS README
}
