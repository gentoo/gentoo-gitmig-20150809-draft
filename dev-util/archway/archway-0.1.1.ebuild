# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/archway/archway-0.1.1.ebuild,v 1.1 2005/01/21 23:26:32 arj Exp $

inherit eutils

DESCRIPTION="A GUI for GNU Arch"

HOMEPAGE="http://www.nongnu.org/archway/"
SRC_URI="http://savannah.nongnu.org/download/archway/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=">=dev-util/tla-1.1
	>=dev-lang/perl-5.8.0
	>=dev-perl/gtk2-perl-1.040
	>=dev-perl/glib-perl-1.040
	>=x11-libs/gtk+-2.4.0"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

## archway uses a simple Makefile
## - no configuration
## - doesn't compile anything
#src_compile() {
#}

src_install() {
	make \
		DESTDIR=${D} \
		prefix=/usr \
		install || die
}
