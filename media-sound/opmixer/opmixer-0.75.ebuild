# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/opmixer/opmixer-0.75.ebuild,v 1.18 2006/02/16 08:53:10 flameeyes Exp $

inherit eutils

IUSE=""

MY_P=${P/opm/opM}
S=${WORKDIR}/${MY_P}
DESCRIPTION="OSS mixer written in C++ with GTKmm GUI."
HOMEPAGE="http://optronic.sourceforge.net/"
SRC_URI="http://optronic.sourceforge.net/files/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~amd64"

DEPEND="=x11-libs/gtk+-1.2*
	=dev-cpp/gtkmm-1.2*"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc34.patch
}

src_compile() {
	econf || die "configure failed"

	#gcc3.2 fix for #8760
	cd ${S}/src
	sed -i -e 's/ endl/ std::endl/' \
		volset.cc

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
