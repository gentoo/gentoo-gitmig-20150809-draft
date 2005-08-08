# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-2.10.1.ebuild,v 1.9 2005/08/08 14:51:59 corsair Exp $

inherit gnome2 eutils flag-o-matic

DESCRIPTION="Collection of games for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="guile artworkextra howl"

RDEPEND=">=x11-libs/gtk+-2.5.4
	>=gnome-base/gconf-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/librsvg-2
	guile? ( >=dev-util/guile-1.6.5 )
	artworkextra? ( gnome-extra/gnome-games-extra-data )
	howl? ( >=net-misc/howl-0.9.6 )"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29
	>=sys-devel/gettext-0.10.40
	>=app-text/scrollkeeper-0.3.8
	${RDEPEND}"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README TODO"

G2CONF="${G2CONF} `use_enable howl` --disable-setgid"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.9.6-nohowl.patch

	autoconf || die "autoconf failed"
}

src_install() {

	# FIXME : for some reason this doesn't get picked up
	append-ldflags "-Wl,-z,now"

	gnome2_src_install
	cd ${S}

	# Documentation install for each of the games
	for game in `find . -type d -maxdepth 1`
	do
		docinto ${game}
		dodoc ${game}/{AUTHORS,ChangeLog,TODO,NEWS,README,COPYING} > /dev/null
	done

	rm -rf ${D}/usr/share/doc/${P}/{libgames-support,po}

	# Avoid overwriting previous .scores files
	local basefile
	for scorefile in ${D}/var/lib/games/*.scores
	do
		basefile=$(basename $scorefile)
		if [ -s "${ROOT}/var/lib/games/${basefile}" ]
		then
		rm ${scorefile}
	fi
	done

}

pkg_postinst() {

	gnome2_pkg_postinst

	einfo "For security reasons system wide scores are disabled by default from"
	einfo "now on. To re-enable them, do 'chmod +s <exec>', where <exec> is all"
	einfo "executables that 'qpkg -l -nc gnome-games | grep /usr/bin/' yields"
	einfo "(requires gentoolkit)."

}
