# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/glark/glark-1.4.ebuild,v 1.1 2002/05/13 00:16:13 karltk Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="File searcher"
SRC_URI="http://belnet.dl.sourceforge.net/sourceforge/glark/${P}.tar.gz"
HOMEPAGE="http://glark.sf.net"
LICENSE="LGPL-2.1"
DEPEND=">=dev-lang/ruby-1.6.7"
RDEPEND="$DEPEND"
SLOT="0"

src_compile() {
	emake || die
}

src_install () {
	dobin glark
	doman glark.1
}
