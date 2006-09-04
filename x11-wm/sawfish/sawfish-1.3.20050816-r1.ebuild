# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sawfish/sawfish-1.3.20050816-r1.ebuild,v 1.5 2006/09/04 05:23:06 tsunam Exp $

# detect cvs snapshots; fex. 1.3.20040120
[[ $PV == *.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] ]]
(( snapshot = !$? ))

inherit eutils

DESCRIPTION="Extensible window manager using a Lisp-based scripting language"
HOMEPAGE="http://sawmill.sourceforge.net/"
if (( snapshot )); then
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
else
	SRC_URI="mirror://sourceforge/sawmill/${P}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ppc sparc x86"
IUSE="gnome esd nls audiofile pango"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=x11-libs/rep-gtk-0.17
	>=dev-libs/librep-0.16
	>=x11-libs/gtk+-2.0.8
	audiofile? ( >=media-libs/audiofile-0.2.3 )
	esd? ( >=media-sound/esound-0.2.23 )
	nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}"

if (( snapshot )); then
	DEPEND="${DEPEND}
		sys-devel/automake
		sys-devel/autoconf"
	S="${WORKDIR}/${PN}"
fi

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/libtool.patch"
	# Fix utf8 with xft #121772
	epatch "${FILESDIR}/sawfish-xft-menu-utf8.patch"
}

src_compile() {
	# Make sure we include freetype2 headers before freetype1 headers,
	# else Xft2 borks, <azarah@gentoo.org> (13 Dec 2002)
	export C_INCLUDE_PATH="${C_INCLUDE_PATH}:/usr/include/freetype2"
	export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:/usr/include/freetype2"

	# If this is a snapshot then we need to create the autoconf stuff
	if (( snapshot )); then
		aclocal || die "aclocal failed"
		autoconf || die "autoconf failed"
	fi

	set -- \
		--disable-themer \
		--with-gdk-pixbuf \
		$(use_with audiofile) \
		$(use_with esd) \
		$(use_with pango)

	if use gnome; then
		set -- "$@" \
			--with-gnome-prefix=/usr \
			--enable-gnome-widgets \
			--enable-capplet
	else
		set -- "$@" \
			--disable-gnome-widgets \
			--disable-capplet
	fi

	if ! use nls; then
		# Use a space because configure script reads --enable-linguas="" as
		# "install everything"
		# Don't use --disable-linguas, because that means --enable-linguas="no",
		# which means "install Norwegian translations"
		set -- "$@" --enable-linguas=" "
	elif [[ "${LINGUAS+set}" == "set" ]]; then
		strip-linguas -i po
		set -- "$@" --enable-linguas=" ${LINGUAS} "
	else
		set -- "$@" --enable-linguas=""
	fi

	econf "$@" || die "configure failed"

	# The following two lines allow sawfish to compile with gcc 2.95
	# (see bug 18294)
	sed -i -e 's:REP_CFLAGS=:REP_CFLAGS=-I/usr/include/freetype2 :' Makedefs

	# Parallel build doesn't work
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog DOC FAQ NEWS README THANKS TODO OPTIONS
}
