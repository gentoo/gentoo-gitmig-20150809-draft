# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/detox/detox-1.1.0.ebuild,v 1.1 2005/03/05 21:55:55 ciaranm Exp $

DESCRIPTION="detox safely removes spaces and strange characters from filenames"
HOMEPAGE="http://detox.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~mips ~hppa"
IUSE=""

DEPEND="dev-libs/popt
	sys-devel/flex
	sys-devel/bison"

RDEPEND="dev-libs/popt"

src_unpack() {
	unpack ${A}
	cd ${S}

	# make DESTDIR installs work
	sed -i -e '/\${INSTALL}/s,\(^.*\)\$,\1${DESTDIR}/$,g' Makefile.in \
		|| die "Makefile.in fix 1 failed. That isn't supposed to happen."
}

src_compile() {
	econf --with-popt || die "econf failed"

	# The lengths I go to to get parallel make to work. Ain't I kind?
	emake -j 1 config_file_l.c
	emake -j 1 config_file_y.h
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README CHANGES
}

