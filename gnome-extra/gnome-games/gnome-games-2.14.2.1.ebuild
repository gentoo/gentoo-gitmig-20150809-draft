# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-2.14.2.1.ebuild,v 1.14 2006/10/20 23:52:04 agriffis Exp $

inherit eutils gnome2 autotools

DESCRIPTION="Collection of games for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="artworkextra guile"

RDEPEND=">=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnome-2
	>=x11-libs/gtk+-2.8
	>=gnome-base/librsvg-2
	>=gnome-base/libglade-2
	>=dev-libs/glib-2.6.3
	>=gnome-base/gnome-vfs-2
	>=x11-libs/cairo-1
	guile? ( >=dev-util/guile-1.6.5 )
	artworkextra? ( gnome-extra/gnome-games-extra-data )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35
	>=dev-util/gob-2.0.0
	>=sys-devel/gettext-0.10.40
	>=gnome-base/gnome-common-2.12.0
	>=app-text/scrollkeeper-0.3.8"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README TODO"


pkg_setup() {
	GAMES_GROUP=${GAMES_GROUP:-games}
	enewgroup "${GAMES_GROUP}"

	G2CONF="--with-scores-group=${GAMES_GROUP} \
		$(use_enable guile)"
}

src_unpack() {
	gnome2_src_unpack

	# Resolve symbols at execution time in setgid binaries
	epatch ${FILESDIR}/${PN}-2.14.0-no_lazy_bindings.patch

	# Implement --enable-guile switch
	epatch ${FILESDIR}/${PN}-2.13.1-guile_switch.patch

	eautoreconf
}

src_install() {
	gnome2_src_install

	# Documentation install for each of the games
	for game in \
	$(find . -maxdepth 1 -type d ! -name po ! -name libgames-support); do
		docinto ${game}
		for doc in AUTHORS ChangeLog NEWS README TODO; do
			[ -s ${game}/${doc} ] && dodoc ${game}/${doc}
		done
	done

	# Avoid overwriting previous .scores files
	local basefile
	for scorefile in ${D}/var/lib/games/*.scores; do
		basefile=$(basename $scorefile)
		if [ -s "${ROOT}/var/lib/games/${basefile}" ]; then
			rm ${scorefile}
		fi
	done
}
