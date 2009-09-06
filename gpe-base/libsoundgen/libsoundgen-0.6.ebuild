# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/libsoundgen/libsoundgen-0.6.ebuild,v 1.2 2009/09/06 16:38:15 miknix Exp $

GPE_TARBALL_SUFFIX="bz2"
inherit gpe autotools

DESCRIPTION="Sound generator library for the GPE Palmtop Environment and gpe-calendar."

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""
GPE_DOCS="AUTHORS COPYING.LIB ChangeLog"

RDEPEND="${RDEPEND}
	>=dev-libs/glib-2.0"

DEPEND="${DEPEND}
	media-sound/esound
	${RDEPEND}"

src_unpack() {
	gpe_src_unpack "$@"

	# gtk-doc is currently not used
	sed -i -e 's;GTK_DOC_CHECK(1.2);;' configure.ac \
		|| die "Fail to sed configure.ac"

	eautoreconf
}
