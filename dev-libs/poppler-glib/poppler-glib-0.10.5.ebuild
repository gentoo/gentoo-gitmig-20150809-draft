# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/poppler-glib/poppler-glib-0.10.5.ebuild,v 1.1 2009/04/01 14:44:00 loki_val Exp $

EAPI=2

POPPLER_MODULE=glib

inherit poppler

DESCRIPTION="Glib bindings for poppler"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="+cairo"

RDEPEND="
	~dev-libs/poppler-${PV}
	>=dev-libs/glib-2.16
	cairo? ( >=x11-libs/cairo-1.4 )
	"
DEPEND="
	${RDEPEND}
	dev-util/pkgconfig
	"

pkg_setup() {
	POPPLER_CONF="$(use_enable cairo cairo-output)"
	POPPLER_PKGCONFIG=( poppler-glib.pc cairo=poppler-cairo.pc )
}

src_prepare() {
	poppler_src_prepare
	sed -i	\
		-e 's:reference::'	\
		-e 's:demo::'		\
		glib/Makefile.in || die "Fixing glib Makefile.in failed"
}

src_compile() {
	use cairo && POPPLER_MODULE_S="${S}/poppler" poppler_src_compile libpoppler-cairo.la
	poppler_src_compile
}
