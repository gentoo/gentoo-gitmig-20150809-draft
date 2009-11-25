# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sawfish/sawfish-1.5.3.ebuild,v 1.1 2009/11/25 20:58:35 truedfx Exp $

# detect cvs snapshots; fex. 1.3_p20040120
[[ $PV == *_p[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] ]]
(( snapshot = !$? ))

if (( snapshot )); then
	inherit eutils autotools
else
	inherit eutils
fi

DESCRIPTION="Extensible window manager using a Lisp-based scripting language"
HOMEPAGE="http://sawmill.sourceforge.net/"
if (( snapshot )); then
	SRC_URI="mirror://gentoo/${P/_p/.}.tar.bz2"
else
	SRC_URI="mirror://sourceforge/sawmill/${P}.tar.bz2"
fi

LICENSE="GPL-2 Artistic-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="audiofile esd nls"

RDEPEND=">=dev-libs/librep-0.90.0
	>=x11-libs/rep-gtk-0.90.0
	>=x11-libs/pango-1.8.0
	>=x11-libs/gtk+-2.6.0
	audiofile? ( >=media-libs/audiofile-0.2.3 )
	esd? ( >=media-sound/esound-0.2.23 )
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

if (( snapshot )); then
	S="${WORKDIR}/${PN}"
fi

src_unpack() {
	unpack ${A}
	cd "${S}"

	if (( snapshot )); then
		eautoreconf
	fi
}

src_compile() {
	set -- \
		--with-gdk-pixbuf \
		$(use_with audiofile) \
		$(use_with esd)

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
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog DOC FAQ NEWS OPTIONS README README.IMPORTANT TODO
}
