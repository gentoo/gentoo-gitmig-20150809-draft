# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/blueglass-xcursors/blueglass-xcursors-0.4.ebuild,v 1.13 2004/11/24 02:39:14 geoman Exp $

MY_P="5532-BlueGlass-XCursors-3D-${PV}"
DESCRIPTION="A high quality set of Xfree 4.3.0 animated mouse cursors"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=5532"
SRC_URI="http://kde-look.org/content/files/$MY_P.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc ~alpha hppa amd64 mips"
IUSE=""

DEPEND=""
RDEPEND="virtual/x11"

# Note: although the package name is BlueGlass, the tarball & authors directions
# use the directory 'Blue'.
src_install() {
	# Set up X11 implementation
	X11_IMPLEM_P="$(best_version virtual/x11)"
	X11_IMPLEM="${X11_IMPLEM_P%-[0-9]*}"
	X11_IMPLEM="${X11_IMPLEM##*\/}"
	einfo "X11 implementation is ${X11_IMPLEM}."

	dodir /usr/share/cursors/${X11_IMPLEM}/Blue/cursors/
	cp -d ${WORKDIR}/${MY_P:5}/Blue/cursors/* ${D}/usr/share/cursors/${X11_IMPLEM}/Blue/cursors/ || die
	dodoc ${WORKDIR}/${MY_P:5}/README
}

pkg_postinst() {
	einfo "To use this set of cursors, edit or create the file ~/.Xdefaults"
	einfo "and add the following line:"
	einfo "Xcursor.theme: Blue"
	einfo ""
	einfo "Also, you can change the size by adding a line like:"
	einfo "Xcursor.size: 48"
	einfo ""
	einfo "To globally use this set of mouse cursors edit the file:"
	einfo "   /usr/share/cursors/${X11_IMPLEM}/default/index.theme"
	einfo "and change the line:"
	einfo "    Inherits=[current setting]"
	einfo "to"
	einfo "    Inherits=Blue"
	einfo ""
	einfo "Note this will be overruled by a user's ~/.Xdefaults file."
	einfo ""
	ewarn "If you experience flickering, try setting the following line in"
	ewarn "the Device section of your XF86Config:"
	ewarn "Option  \"HWCursor\"  \"false\""
}
