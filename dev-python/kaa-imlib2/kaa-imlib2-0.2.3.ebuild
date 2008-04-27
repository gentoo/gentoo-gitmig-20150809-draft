# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kaa-imlib2/kaa-imlib2-0.2.3.ebuild,v 1.3 2008/04/27 14:18:00 maekke Exp $

inherit python eutils distutils

DESCRIPTION="Imlib2 wrapper for Python."
HOMEPAGE="http://freevo.sourceforge.net/kaa/"
SRC_URI="mirror://sourceforge/freevo/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND=">=dev-python/kaa-base-0.3.0
	dev-libs/libxml2
	media-libs/imlib2"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use dev-libs/libxml2 python; then
		eerror "dev-libs/libxml2 must be built with the 'python' USE flag"
		die "Recompile dev-libs/libxml2 with the 'python' USE flag enabled"
	fi
	if ! built_with_use media-libs/imlib2 png; then
		eerror "media-libs/imlib2 must be built with the 'png' USE flag"
		die "Recompile media-libs/imlib2 with the 'png' USE flag enabled"
	fi
}
