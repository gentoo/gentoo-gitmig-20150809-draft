# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/einit-modules-xml/einit-modules-xml-2.0.0.0.ebuild,v 1.1 2008/03/03 21:26:34 opfer Exp $

inherit python

DESCRIPTION=".xml modules for eINIT"
SRC_URI="http://einit.org/files/${P}.tar.bz2"
HOMEPAGE="http://einit.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=sys-apps/einit-0.40.0"
DEPEND="${RDEPEND}
		dev-util/scons"

src_unpack() {
	unpack ${A} || die
	python_version || die
}

src_compile() {
	scons libdir="$(get_libdir)" destdir="${D}/${ROOT}/" prefix="${ROOT}" || die
}

src_install() {
	scons libdir="$(get_libdir)" destdir="${D}/${ROOT}/" prefix="${ROOT}" install || die
	dodoc AUTHORS ChangeLog README || die
}
