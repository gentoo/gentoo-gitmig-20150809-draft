# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/blueglass-xcursors/blueglass-xcursors-0.3.ebuild,v 1.2 2003/06/27 00:47:48 vapier Exp $

MY_P="5532-BlueGlass-XCursors-3D-${PV}"
DESCRIPTION="A high quality set of Xfree 4.3.0 animated mouse cursors"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=5532"
SRC_URI="http://kde-look.org/content/files/$MY_P.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=""
RDEPEND=">=x11-base/xfree-4.3.0-r2"

# Note: although the package name is BlueGlass, the tarball & authors directions
# use the directory 'Blue'.
src_install() {
	mkdir -p ${D}/usr/share/cursors/xfree/Blue/cursors/
	cp -d Blue/cursors/* ${D}/usr/share/cursors/xfree/Blue/cursors/ || die
	dodoc COPYING README
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
	einfo "   /usr/share/cursors/xfree/default/index.theme"
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
