# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libwacom/libwacom-0.4.ebuild,v 1.1 2012/04/06 05:31:06 tetromino Exp $

EAPI=4
inherit gnome.org

DESCRIPTION="Library for identifying Wacom tablets and their model-specific features"
HOMEPAGE="http://linuxwacom.sourceforge.net/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

RDEPEND="dev-libs/glib:2
	sys-fs/udev[gudev]"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( app-doc/doxygen )"

src_prepare() {
	if ! use doc; then
		sed -e 's:^\(SUBDIRS = .* \)doc:\1:' -i Makefile.in || die "sed failed"
	fi
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	use doc && dohtml -r doc/html/*
	find "${D}" -name '*.la' -exec rm -f {} + || die "la file removal failed"
}
