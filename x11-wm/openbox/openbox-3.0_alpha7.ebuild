# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-3.0_alpha7.ebuild,v 1.2 2003/09/03 14:24:45 tseng Exp $

S=${WORKDIR}/${P/_/-}
DESCRIPTION="Openbox is a standards compliant, fast, light-weight, extensible window manager."
SRC_URI="http://icculus.org/openbox/releases/${P/_/-}.tar.gz"
HOMEPAGE="http://icculus.org/openbox/"
IUSE="nls"
SLOT="3"

DEPEND="virtual/xft
	virtual/x11
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/libglade-2"
RDEPEND=${DEPEND}

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_compile() {

	econf \
		`use_enable nls` \
		--program-suffix="3" || die
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc README AUTHORS ChangeLog TODO
}

pkg_postinst () {
	einfo "This release moves the menu back to its own file."
	einfo "There are also many changes in the rc3 file."
	einfo "Please check out the examples in /usr/share/openbox/ before running."
}
