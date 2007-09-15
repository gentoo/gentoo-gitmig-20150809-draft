# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SpeedyCGI/SpeedyCGI-2.22.ebuild,v 1.1 2007/09/15 22:06:32 hansmi Exp $

inherit perl-module

DESCRIPTION="Speed up perl scripts by running them persistently"
HOMEPAGE="http://daemoninc.com/SpeedyCGI/"
SRC_URI="http://daemoninc.com/SpeedyCGI/CGI-${P}.tar.gz
	http://oss.oetiker.ch/smokeping/pub/speedy-error.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND=""

S="${WORKDIR}/CGI-${P}"

PATCHES="${DISTDIR}/speedy-error.patch"

src_compile() {
	echo '' | perl-module_src_compile
}
