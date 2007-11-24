# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtksourceview/gtksourceview-2.0.1-r1.ebuild,v 1.5 2007/11/24 22:59:52 ranger Exp $

inherit gnome2 eutils autotools

DESCRIPTION="A text widget implementing syntax highlighting and other features"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="2.0"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ppc ~ppc64 ~sh sparc x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.8
	>=dev-libs/libxml2-2.5
	>=dev-libs/glib-2
	>=dev-libs/libpcre-7.4"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README TODO"

pkg_setup() {
	# Removes the gnome-vfs dep
	G2CONF="${G2CONF} --disable-build-tests --with-system-pcre"
}

src_install() {
	gnome2_src_install

	insinto /usr/share/${PN}-2.0/language-specs
	doins "${FILESDIR}"/2.0/gentoo.lang
}
