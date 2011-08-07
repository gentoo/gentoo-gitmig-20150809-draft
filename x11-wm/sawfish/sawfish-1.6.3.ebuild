# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sawfish/sawfish-1.6.3.ebuild,v 1.5 2011/08/07 17:40:59 armin76 Exp $

EAPI="1"

# detect cvs snapshots; fex. 1.3_p20040120
[[ $PV == *_p[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] ]]
(( snapshot = !$? ))

if (( snapshot )); then
	inherit eutils autotools
else
	inherit eutils
fi

DESCRIPTION="Extensible window manager using a Lisp-based scripting language"
HOMEPAGE="http://sawfish.wikia.com/"
if (( snapshot )); then
	SRC_URI="mirror://gentoo/${P/_p/.}.tar.bz2"
else
	SRC_URI="http://download.tuxfamily.org/sawfish/sawfish/${P}.tar.bz2"
fi

LICENSE="GPL-2 Artistic-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc x86"
IUSE="nls xinerama"

RDEPEND=">=dev-libs/librep-0.90.5
	>=x11-libs/rep-gtk-0.90.2
	>=x11-libs/pango-1.8.0
	>=x11-libs/gtk+-2.12.0:2
	nls? ( sys-devel/gettext )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

if (( snapshot )); then
	S="${WORKDIR}/${PN}"
fi

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-prompt.patch

	if (( snapshot )); then
		eautoreconf
	fi
}

src_compile() {
	set -- \
		$(use_with xinerama) \
		--with-gdk-pixbuf

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
