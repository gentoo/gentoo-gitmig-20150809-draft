# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/archway/archway-0.1.0.ebuild,v 1.1 2005/01/17 05:39:21 arj Exp $

inherit eutils

DESCRIPTION="A GUI for Gnu Arch (better known as tla)"

HOMEPAGE="http://www.nongnu.org/archway/"
SRC_URI="http://savannah.nongnu.org/download/archway/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=">=dev-util/tla-1.1
	>=dev-lang/perl-5.6
	>=dev-perl/gtk2-perl-1.0
	>=dev-perl/glib-perl-1.0
	>=x11-libs/gtk+-2.4"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

## archway uses a simple Makefile
## - no configuration
## - doesn't compile anything
#src_compile() {
#}

src_install() {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		libdir=${D}/usr/$(get_libdir) \
		install || die

	# but the makefile does some sed's (via perl)
	# so the installed scripts search in /var/tmp
	# for additional stuff :-(
	# this solves that

	dosed "s:${D}/usr/share/archway/perllib:/usr/share/archway/perllib:" /usr/bin/archway
	dosed "s:${D}/usr/share/archway:/usr/share/archway:" /usr/share/archway/perllib/ArchWay/Session.pm

}
