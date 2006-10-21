# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparted/pyparted-1.7.0.ebuild,v 1.8 2006/10/21 01:23:12 agriffis Exp $

RH_EXTRAVERSION="1"

inherit eutils rpm flag-o-matic

DESCRIPTION="Python bindings for parted"
HOMEPAGE="http://fedora.redhat.com"
SRC_URI="http://download.fedora.redhat.com/pub/fedora/linux/core/development/SRPMS/${P}-${RH_EXTRAVERSION}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86"
IUSE=""

# Needed to build...
DEPEND="=dev-lang/python-2.4*
	>=sys-apps/parted-1.7.0"

src_unpack() {
	rpm_src_unpack
	cd "${S}"
	sed -i -e 's:device.h:parted.h:' pydevice.h
	sed -i -e 's:disk.h:parted.h:' pydisk.h pyfilesystem.h
	sed -i -e 's:geom.h:parted.h:' pygeometry.h
}

src_compile() {
	# -fPIC needed for compilation on amd64, applied globally as only one shared
	# lib is produced by this package.
	append-flags -fPIC

	# This is needed otherwise it won't build
	# If anyone wants to figure out why... go ahead!
	export LDFLAGS="-ldl"
	econf || die
	emake || die
}

src_install () {
	einstall || die "Install failed!"
	dodoc AUTHORS COPYING README ChangeLog
}
