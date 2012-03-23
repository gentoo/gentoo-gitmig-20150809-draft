# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/exo/exo-0.7.1.ebuild,v 1.3 2012/03/23 21:13:06 angelos Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Extensions, widgets and framework library with session management support"
HOMEPAGE="http://www.xfce.org/projects/exo/"
SRC_URI="mirror://xfce/src/xfce/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris"
IUSE="debug"

RDEPEND=">=dev-lang/perl-5.6
	>=dev-libs/glib-2.18:2
	dev-perl/URI
	>=x11-libs/gtk+-2.14:2
	>=xfce-base/libxfce4ui-4.9
	>=xfce-base/libxfce4util-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		$(xfconf_use_debug)
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
		)

	[[ ${CHOST} == *-darwin* ]] && XFCONF+=( --disable-visibility ) #366857

	DOCS=( AUTHORS ChangeLog HACKING NEWS README THANKS TODO )
}
