# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ppl/ppl-0.10_pre27.ebuild,v 1.1 2008/09/21 09:26:44 vapier Exp $

MY_P="${P/_pre/pre}"

DESCRIPTION="The Parma Polyhedra Library (PPL) is a modern and reasonably complete library providing numerical abstractions especially targeted at applications in the field of analysis and verification of complex systems"
HOMEPAGE="http://www.cs.unipr.it/ppl/"
SRC_URI="ftp://ftp.cs.unipr.it/pub/ppl/snapshots/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc BUGS ChangeLog NEWS README STANDARDS TODO
}
