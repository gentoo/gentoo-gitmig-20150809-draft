# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/atk/atk-1.10.2.ebuild,v 1.2 2005/08/31 11:44:34 leonardop Exp $

inherit gnome2

DESCRIPTION="GTK+ & GNOME Accessibility Toolkit"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="doc static"

RDEPEND=">=dev-libs/glib-2.5.7"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"


pkg_setup() {
	G2CONF="$(use_enable static)"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Re-generate ltmain.sh, configure and friends, since the upstream tarball
	# was built with a buggy libtool (missing 'so' extension in binaries).
	export WANT_AUTOMAKE=1.7
	cp aclocal.m4 old_macros.m4
	libtoolize --copy --force
	aclocal -I . || die "aclocal failed"
	autoconf || die "autoconf failed"
}
