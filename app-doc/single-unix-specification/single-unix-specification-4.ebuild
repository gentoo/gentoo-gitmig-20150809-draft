# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/single-unix-specification/single-unix-specification-4.ebuild,v 1.1 2009/09/11 19:29:14 patrick Exp $

DESCRIPTION="The Single UNIX Specification, Version 4, 2008 Edition (8 Volumes)"
HOMEPAGE="http://www.opengroup.org/bookstore/catalog/c082.htm"
SRC_URI="http://www.opengroup.org/onlinepubs/9699919799/download/susv4.tar.bz2"

LICENSE="as-is"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND=""

S="${WORKDIR}/susv4"

src_install() {
	insinto /usr/share/doc/${PF}/html
	doins -r * || die "doins"
}
