# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/stratego/stratego-0.8.1.ebuild,v 1.5 2003/01/09 22:10:01 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Stratego term-rewriting language"
SRC_URI="http://www.stratego-language.org/ftp/${P}.tar.gz"
HOMEPAGE="http://www.stratego-language.org"
DEPEND=">=dev-libs/aterm-1.6.7
	>=dev-libs/cpl-stratego-0.4"
RDEPEND="$DEPEND"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha" 
IUSE=""

src_compile() {
	# 2002-11-02, karltk@gentoo.org:
	# The Stratego build system is b0rken; it installs before 
        # compilation is finished. Thorougly annoying.
	econf || die "econf failed"
	make DESTDIR=${D} -C srts install || die
	make INCLUDES=-I${D}usr/include \
		LDFLAGS="-L${S}/ssl/src -L${S}/srts/src" \
		DESTDIR=${D} || die
}

src_install () {
	make DESTDIR=${D} install || die
}
