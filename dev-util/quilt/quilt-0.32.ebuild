# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/quilt/quilt-0.32.ebuild,v 1.6 2005/02/02 23:47:23 vapier Exp $

inherit eutils

DESCRIPTION="quilt patch manager"
HOMEPAGE="http://savannah.nongnu.org/projects/quilt"
SRC_URI="http://savannah.nongnu.org/download/quilt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="bash-completion"

DEPEND="sys-devel/patch
	>=sys-apps/sed-4
	app-arch/bzip2
	app-arch/gzip
	dev-util/diffstat
	sys-apps/gawk
	sys-apps/sed
	dev-lang/perl"

src_install() {
	make BUILD_ROOT="${D}" install || die
	use bash-completion || rm -r "${D}"/etc/bash_completion.d
	dodoc AUTHORS BUGS TODO
}
