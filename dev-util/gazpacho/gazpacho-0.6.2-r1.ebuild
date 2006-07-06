# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gazpacho/gazpacho-0.6.2-r1.ebuild,v 1.1 2006/07/06 17:18:28 pythonhead Exp $

inherit distutils gnome.org eutils

DESCRIPTION="Gazpacho is a glade-like gtk interface designer."
HOMEPAGE="http://gazpacho.sicem.biz/"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=dev-python/pygtk-2.4
	>=gnome-base/libglade-2.4.2"

DOCS="AUTHORS NEWS"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-setup-fixes.patch"
	epatch "${FILESDIR}/${P}-amd64-fixes.patch"

	# In an attempt to make the above patch reusable across gazpacho
	# versions it patched in EBUILD_PF_HERE and EBUILD_PV_HERE markers
	# instead of hardcoding version numbers in the patch.
	sed -i -e "s/EBUILD_PF_HERE/${PF}/" \
		-e "s/EBUILD_PV_HERE/${PV}/" \
		setup.py
}

src_install() {
	distutils_src_install
	docinto internals
	dodoc doc/*
	insinto /usr/share/doc/${PF}
	# these are needed in un-gzipped form or the "about" box crashes
	doins AUTHORS CONTRIBUTORS COPYING
	rm "${D}"/usr/share/doc/${PF}/{AUTHORS,CONTRIBUTORS}.gz
}
