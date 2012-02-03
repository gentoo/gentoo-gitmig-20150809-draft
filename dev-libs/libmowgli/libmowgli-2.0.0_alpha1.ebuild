# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmowgli/libmowgli-2.0.0_alpha1.ebuild,v 1.2 2012/02/03 01:10:52 binki Exp $

EAPI=4

MY_P=${P/_/-}

DESCRIPTION="Useful set of performance and usability-oriented extensions to C"
HOMEPAGE="http://www.atheme.org/project/mowgli"
SRC_URI="http://atheme.org/downloads/${MY_P}.tar.gz"
IUSE="examples"

LICENSE="BSD-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf $(use_enable examples)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS README doc/BOOST
}
