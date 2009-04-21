# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfconf/xfconf-4.6.1.ebuild,v 1.1 2009/04/21 04:26:31 darkside Exp $

EAPI="1"

inherit xfce4

xfce4_core

DESCRIPTION="Xfce configuration daemon and utilities"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="debug doc -perl"

RDEPEND=">=dev-libs/dbus-glib-0.72
	>=dev-libs/glib-2.12:2
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	perl? ( dev-perl/glib-perl )"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	perl? ( dev-perl/extutils-depends
		dev-perl/extutils-pkgconfig )"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable doc gtk-doc) $(use_enable perl perl-bindings)"
}

src_compile() {
	xfce4_src_configure
	emake OTHERLDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	xfce4_src_install

	# stolen from perl-module.eclass
	find "${D}" -type f -name perllocal.pod -delete
	find "${D}" -depth -mindepth 1 -type d -empty -delete
}

DOCS="AUTHORS ChangeLog NEWS README TODO"
