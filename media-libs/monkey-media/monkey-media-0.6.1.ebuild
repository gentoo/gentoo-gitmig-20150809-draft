# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/monkey-media/monkey-media-0.6.1.ebuild,v 1.3 2003/03/16 14:51:21 azarah Exp $

IUSE="doc"

inherit eutils gnome2

S="${WORKDIR}/${P}"
DESCRIPTION="Library wrapping gstreamer able to play media file"
SRC_URI="http://www.rhythmbox.org/download/${P}.tar.gz"
HOMEPAGE="http://www.rhythmbox.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

RDEPEND="
	>=x11-libs/gtk+-2.0.6
	>=dev-libs/atk-1.0
	>=dev-libs/glib-2.0
	>=media-libs/audiofile-0.2.3
	>=gnome-base/gnome-vfs-2.0
	=media-libs/gstreamer-0.4.2*
	>=gnome-base/gconf-1.2.0
	>=gnome-base/libglade-2.0
	>=gnome-base/ORBit2-2.4
	sys-devel/gettext
	sys-libs/zlib
	media-libs/libogg
	media-libs/libvorbis
	>=media-sound/mad-0.14.2b
	media-libs/musicbrainz"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"


src_unpack() {
	unpack ${A}

	cd ${S};
	# Update the missing command else it fails during configure ...
	rm -f ${S}/missing
	automake --add-missing

	# Fix to detect gstreamer-0.5 ...
# Currently this causes issues ...
#	epatch ${FILESDIR}/${P}-gstreamer-0.5.patch
}

src_compile () {
	gnome2_src_configure

	# Remove "-I/usr/include" from the Makefiles
	find . -iname makefile |while read MAKEFILE
		do einfo "parsing ${MAKEFILE}"
		cp ${MAKEFILE}  ${MAKEFILE}.old
		sed -e "s:-I/usr/include : :g" \
		    -e "s:-Werror::g" \
		    ${MAKEFILE}.old > ${MAKEFILE}
	done
	
	emake || die "compile failed" 
}

DOC="AUTHORS COPYING ChangeLog HACKING INSTALL INSTALL.GNU NEWS README THANKS TODO"
