# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/golden-xcursors/golden-xcursors-0.7-r1.ebuild,v 1.6 2004/10/04 01:33:03 spyderous Exp $

MY_P="5507-Golden-XCursors-3D-${PV}"
DESCRIPTION="A high quality set of Xfree 4.3.0 animated mouse cursors"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=5507"
SRC_URI="http://www.kde-look.org/content/files/$MY_P.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""
DEPEND=""
RDEPEND="virtual/x11"

src_install() {
	# Set up X11 implementation
	X11_IMPLEM_P="$(best_version virtual/x11)"
	X11_IMPLEM="${X11_IMPLEM_P%-[0-9]*}"
	X11_IMPLEM="${X11_IMPLEM##*\/}"
	einfo "X11 implementation is ${X11_IMPLEM}."

	dodir /usr/share/cursors/${X11_IMPLEM}/Gold/cursors/
	cp -d ${WORKDIR}/${MY_P:5}/Gold/cursors/* ${D}/usr/share/cursors/${X11_IMPLEM}/Gold/cursors/ || die
	dodoc ${WORKDIR}/${MY_P:5}/README
}

pkg_postinst() {
	einfo "To use this set of cursors, edit or create the file ~/.Xdefaults"
	einfo "and add the following line:"
	einfo "Xcursor.theme: gold"
	einfo ""
	einfo "Also, you can change the size by adding a line like:"
	einfo "Xcursor.size: 48"
	einfo ""
	einfo ""
	einfo "To globally use this set of mouse cursors edit the file:"
	einfo "   /usr/share/cursors/${X11_IMPLEM}/default/index.theme"
	einfo "and change the line:"
	einfo "   Inherits=[current setting]"
	einfo "to"
	einfo "   Inherits=gold"
	einfo "Note this will be overruled by a user's ~/.Xdefaults file"
	einfo ""
	ewarn "If you experience flickering, try setting the following line in"
	ewarn "the Device section of your XF86Config:"
	ewarn "Option  \"HWCursor\"  \"false\""
}
