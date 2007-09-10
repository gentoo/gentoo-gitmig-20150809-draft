# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kaa-imlib2/kaa-imlib2-0.2.1.ebuild,v 1.4 2007/09/10 20:34:59 maekke Exp $

inherit python eutils distutils

DESCRIPTION="Imlib2 wrapper for Python."
HOMEPAGE="http://freevo.sourceforge.net/kaa/"
SRC_URI="mirror://sourceforge/freevo/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND=">=dev-python/kaa-base-0.1.3
	dev-libs/libxml2
	media-libs/imlib2"
RDEPEND="${DEPEND}"

pkg_setup() {
	if !(built_with_use dev-libs/libxml2 python); then
		eerror "dev-libs/libxml2 must be built with the 'python' USE flag"
		die "Recompile dev-libs/libxml2 with the 'python' USE flag enabled"
	fi
}
