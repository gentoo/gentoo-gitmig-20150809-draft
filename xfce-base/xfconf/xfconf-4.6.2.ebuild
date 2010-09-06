# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfconf/xfconf-4.6.2.ebuild,v 1.12 2010/09/06 17:50:27 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Xfce configuration daemon and utilities"
HOMEPAGE="http://www.xfce.org"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.6/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
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
		--disable-static
		--with-perl-options=INSTALLDIRS=vendor
		$(use_enable perl perl-bindings)
		$(use_enable debug)
		$(use_enable debug checks)"
	use profile && XFCONF="${XFCONF} --enable-profiling"
	DOCS="AUTHORS ChangeLog NEWS TODO"
}

src_compile() {
	emake OTHERLDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	xfconf_src_install

	if use perl; then
		# Prefix compat. In Gentoo Linux, defaults to ${D}
		[[ -z ${ED} ]] && local ED=${D}
		find "${ED}" -type f -name perllocal.pod -delete
		find "${ED}" -depth -mindepth 1 -type d -empty -delete
	fi
}
