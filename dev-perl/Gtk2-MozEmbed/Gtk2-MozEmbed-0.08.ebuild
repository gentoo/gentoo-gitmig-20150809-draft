# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-MozEmbed/Gtk2-MozEmbed-0.08.ebuild,v 1.1 2008/12/23 18:56:21 robbat2 Exp $

inherit perl-module

DESCRIPTION="Interface to the Mozilla embedding widget"
HOMEPAGE="http://search.cpan.org/~tsch"
SRC_URI="mirror://cpan/authors/id/T/TS/TSCH/${P}.tar.gz"

IUSE="firefox"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~sparc ~x86"

RDEPEND=">=dev-perl/gtk2-perl-1.144
	firefox? ( www-client/mozilla-firefox )
	!firefox? ( www-client/seamonkey )"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.205
	>=dev-perl/extutils-pkgconfig-1.07"
