# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfconf/xfconf-4.6.1.ebuild,v 1.11 2009/08/01 21:21:53 ssuominen Exp $

EAPI=2
inherit flag-o-matic xfconf

DESCRIPTION="Xfce configuration daemon and utilities"
HOMEPAGE="http://www.xfce.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="debug -perl profile"

RDEPEND=">=dev-libs/dbus-glib-0.72
	>=dev-libs/glib-2.12:2
	>=xfce-base/libxfce4util-4.6
	perl? ( dev-perl/glib-perl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	perl? ( dev-perl/extutils-depends
		dev-perl/extutils-pkgconfig )"

RESTRICT="test"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(use_enable perl perl-bindings)
		$(use_enable debug)
		$(use_enable debug checks)
		$(use_enable profile profiling)"
	DOCS="AUTHORS ChangeLog NEWS TODO"
}

src_configure() {
	use profile && filter-flags -fomit-frame-pointer
	xfconf_src_configure
}

src_compile() {
	emake OTHERLDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	xfconf_src_install

	if use perl; then
		find "${D}" -type f -name perllocal.pod -delete
		find "${D}" -depth -mindepth 1 -type d -empty -delete
	fi
}
