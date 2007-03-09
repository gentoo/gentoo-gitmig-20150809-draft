# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libgeda/libgeda-20060123.ebuild,v 1.10 2007/03/09 20:07:20 calchan Exp $

inherit eutils

HOMEPAGE="http://www.geda.seul.org"
DESCRIPTION="libgeda - this library provides functions needed for the gEDA core suite"
SRC_URI="http://www.geda.seul.org/devel/${PV}/libgeda-${PV}.tar.gz"

IUSE="png"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
SLOT="0"

DEPEND=">=dev-libs/glib-2.4.8
	>=x11-libs/gtk+-2.2
	>=dev-scheme/guile-1.6.3
	>=dev-util/pkgconfig-0.15.0
	png? ( >=sci-libs/libgdgeda-2.0.15 )"

pkg_setup() {
	if has_version ">=dev-scheme/guile-1.8" ; then
		built_with_use "dev-scheme/guile" deprecated \
			|| die "You need either <dev-scheme/guile-1.8, or >=dev-scheme/guile-1.8 with USE=deprecated"
	fi
}

src_compile () {
	local myconf

	use png || myconf='--disable-gdgeda'

	econf ${myconf} || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install () {
	einstall || die "Installation failed"
	dodoc AUTHORS COPYING ChangeLog README
}
