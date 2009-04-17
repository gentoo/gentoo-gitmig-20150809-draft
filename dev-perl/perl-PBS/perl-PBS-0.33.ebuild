# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-PBS/perl-PBS-0.33.ebuild,v 1.1 2009/04/17 21:12:25 jsbronder Exp $

inherit perl-module

DESCRIPTION="perl-PBS is a perl binding for the Portable Batch System client
library"
HOMEPAGE="http://www-rcf.usc.edu/~garrick/perl-PBS/"
SRC_URI="http://www-rcf.usc.edu/~garrick/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	>=sys-cluster/torque-2.3.6
	dev-perl/Curses"
DEPEND="${RDEPEND}
		dev-lang/swig"

src_test() {
	emake test
}
