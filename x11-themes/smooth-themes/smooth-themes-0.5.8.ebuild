# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/smooth-themes/smooth-themes-0.5.8.ebuild,v 1.2 2005/08/04 09:41:44 leonardop Exp $

inherit eutils

DESCRIPTION="A clean set of GTK+ themes based on the Smooth engine"
HOMEPAGE="http://sourceforge.net/projects/smooth-engine/"
SRC_URI="mirror://sourceforge/smooth-engine/${P}.tar.gz"

KEYWORDS="~x86"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="gtk2"

# This package installs both GTK+1 and GTK+2 themes, and tries to set the
# correct runtime dependencies according to the 'gtk2' USE flag. It is a poor
# way to handle the dependencies and themes to install, but it is pretty much
# the best alternative at the moment.
DEPEND=""
RDEPEND="gtk2? ( >=x11-themes/gtk-engines-2 )
	!gtk2? ( x11-themes/gtk-engines-smooth )"

src_unpack() {
	unpack ${A}
	cd ${S}

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
