# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gitg/gitg-0.0.5.ebuild,v 1.2 2009/12/04 10:26:00 fauli Exp $

EAPI="2"

inherit gnome2

DESCRIPTION="git repository viewer for GNOME"
HOMEPAGE="http://trac.novowork.com/gitg/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.16
	>=x11-libs/gtksourceview-2.2
	>=gnome-base/gconf-2.10
	dev-util/git"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.15
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	# Fix intltoolize broken file, see <https://bugzilla.gnome.org/show_bug.cgi?id=577133>
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i "${S}/po/Makefile.in.in" || die "sed failed"
}

pkg_setup() {
	G2CONF="${G2CONF} --disable-bundle"
}
