# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GStreamer/GStreamer-0.09.ebuild,v 1.5 2008/05/16 16:02:53 armin76 Exp $

inherit perl-module

DESCRIPTION="Perl bindings for GStreamer"
HOMEPAGE="http://search.cpan.org/~tsch/"
SRC_URI="mirror://cpan/authors/id/T/TS/TSCH/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~sparc ~x86"
IUSE=""

RDEPEND="=media-libs/gstreamer-0.10*
	>=dev-perl/glib-perl-1.120
	>=dev-perl/extutils-depends-0.205
	>=dev-perl/extutils-pkgconfig-1.07
	dev-lang/perl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
