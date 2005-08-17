# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/jimmac-xcursors/jimmac-xcursors-0.0.1.ebuild,v 1.4 2005/08/17 03:28:47 smithj Exp $

MY_P="6550-Jimmac.tar.gz"
DESCRIPTION="A high quality set of Xfree 4.3.0 animated mouse cursors"
HOMEPAGE="http://jimmac.musichall.cz/i.php3?ikony=71"
SRC_URI="http://kde-look.org/content/files/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/x11"

S=${WORKDIR}/Jimmac

src_install() {
	#X11_IMPLEM_P="$(best_version virtual/x11)"
	#X11_IMPLEM="${X11_IMPLEM_P%-[0-9]*}"
	#X11_IMPLEM="${X11_IMPLEM##*\/}"
	X11_IMPLEM="xorg-x11"
	einfo "X11 implementation is ${X11_IMPLEM}."

	dodir /usr/share/cursors/${X11_IMPLEM}/Jimmac/cursors/
	cp -d  jimmac/cursors/* \
		${D}/usr/share/cursors/${X11_IMPLEM}/Jimmac/cursors/ || die
	dodoc README COPYING
}

pkg_postinst() {
	einfo "To use this set of cursors, edit or create the file ~/.Xdefaults"
	einfo "and add the following line:"
	einfo "Xcursor.theme: Jimmac"
	einfo ""
	einfo "Also, you can change the size by adding a line like:"
	einfo "Xcursor.size: 48"
	einfo ""
	einfo "To globally use this set of mouse cursors edit the file:"
	einfo "	  /usr/share/cursors/${X11_IMPLEM}/default/index.theme"
	einfo "and change the line:"
	einfo "	  Inherits=[current setting]"
	einfo "to"
	einfo "	  Inherits=Jimmac"
	einfo "Note this will be overruled by a user's ~/.Xdefaults file."
	einfo ""
	ewarn "If you experience flickering, try setting the following line in"
	ewarn "the Device section of your XF86Config:"
	ewarn "Option \"HWCursor\" \"false\""
}
