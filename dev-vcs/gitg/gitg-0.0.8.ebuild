# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/gitg/gitg-0.0.8.ebuild,v 1.3 2011/01/02 01:58:02 sping Exp $

EAPI="3"

inherit gnome2

DESCRIPTION="git repository viewer for GNOME"
HOMEPAGE="http://trac.novowork.com/gitg/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.26
	>=x11-libs/gtk+-2.18
	>=x11-libs/gtksourceview-2.8
	>=gnome-base/gconf-2.10
	dev-vcs/git"

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.17
	>=dev-util/pkgconfig-0.15
	>=dev-util/intltool-0.40"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	# Fix intltoolize broken file, see <https://bugzilla.gnome.org/show_bug.cgi?id=577133>
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i "${S}/po/Makefile.in.in" || die "sed failed"
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die "Removal of .la files failed"
}

src_test() {
	emake check || die
}
