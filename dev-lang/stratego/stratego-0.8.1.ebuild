# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/stratego/stratego-0.8.1.ebuild,v 1.15 2004/07/14 13:57:08 agriffis Exp $

DESCRIPTION="Stratego term-rewriting language"
HOMEPAGE="http://www.stratego-language.org/"
SRC_URI="http://www.stratego-language.org/ftp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha ~ia64"
IUSE=""

DEPEND=">=dev-libs/aterm-1.6.7
	>=dev-libs/cpl-stratego-0.4"

src_compile() {
	# 2002-11-02, karltk@gentoo.org:
	# The Stratego build system is b0rken; it installs before
	# compilation is finished. Thorougly annoying.
	econf || die "econf failed"
#	make DESTDIR=${D} -C srts install || die
	make INCLUDES=-I${D}usr/include \
		LDFLAGS="-L${S}/ssl/src -L${S}/srts/src" \
		DESTDIR=${D} || die
}

src_install() {
	make DESTDIR=${D} install || die
}
