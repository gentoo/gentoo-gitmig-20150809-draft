# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gazpacho/gazpacho-0.7.0.ebuild,v 1.1 2006/12/29 12:39:17 ikelos Exp $

inherit distutils gnome.org eutils

DESCRIPTION="Gazpacho is a glade-like gtk interface designer."
HOMEPAGE="http://gazpacho.sicem.biz/"
LICENSE="LGPL-2.1"
SLOT="0"

# Masked amd64 and ppc whilst there's no kiwi available for that package
KEYWORDS="-amd64 -ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=dev-python/pygtk-2.4
	>=gnome-base/libglade-2.4.2
	>=dev-python/kiwi-1.9.11"

DOCS="AUTHORS NEWS"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-setup-fixes.patch"
	epatch "${FILESDIR}/${P}-default-action-group.patch"

	# In an attempt to make the above patch reusable across gazpacho
	# versions it patched in EBUILD_PF_HERE markers
	# instead of hardcoding version numbers in the patch.
	sed -i -e "s/EBUILD_PF_HERE/${PF}/" setup.py
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
