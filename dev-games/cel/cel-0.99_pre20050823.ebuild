# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cel/cel-0.99_pre20050823.ebuild,v 1.2 2007/01/05 04:49:39 flameeyes Exp $

inherit eutils

DESCRIPTION="A game entity layer based on Crystal Space"
HOMEPAGE="http://cel.sourceforge.net/"
SRC_URI="mirror://sourceforge/cel/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug python"

RDEPEND="dev-games/crystalspace
	dev-util/jam
	!dev-games/cel-cvs
	python? ( virtual/python )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}

src_compile() {
	CRYSTAL=$(cs-config --prefix)
	CSCONFPATH=$CRYSTAL
	CRYSTAL_PREFIX=$CRYSTAL
	CEL_PREFIX=$CRYSTAL

	local prefix=${CEL_PREFIX}
	local my_conf=""

	use debug && my_conf="${my_conf} --enable-debug"

	PATH="${prefix}/bin:${PATH}" \
	./configure \
		--prefix="${prefix}" \
		--with-cs-prefix="$CRYSTAL_PREFIX" \
		--enable-new-renderer \
		--disable-jamtest \
		--without-python \
		${my_conf} \
		|| die "configure failed"
		#$(use_with python)

	jam || die "jam failed"
}

src_install() {
	local prefix=${CEL_PREFIX}
	jam -sprefix="${D}"${prefix} install || die

	# Symlink cel-config into /usr/bin
	dodir /usr/bin
	dosym ${CRYSTAL_PREFIX}/bin/cel-config /usr/bin/cel-config
}
