# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/plucker/plucker-1.8.ebuild,v 1.4 2004/07/19 22:00:07 kloeri Exp $

inherit python

DESCRIPTION="Distiller for Plucker -- offline ebook reader for Palm devices"
HOMEPAGE="http://www.plkr.org/"
SRC_URI="http://downloads.plkr.org/${PV}/${PN}_src-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-lang/python-1.5.2"
RDEPEND=">=dev-lang/python-1.5.2
		|| (
			>=media-gfx/imagemagick-5.4.4
			>=dev-python/imaging-1.1
			>=media-libs/netpbm-9.15
		)"

src_compile() {
	econf \
		--disable-palmosbuild \
		--disable-desktopbuild \
		--disable-gtkviewer \
		--disable-docbuild \
		--with-docdir=/usr/share/doc/${PF} \
		|| die "econf failed"

	# breaks when built in parallel
	emake -j1 || die "emake failed"

	# "make install" will try to access this non-existent file
	touch TODO
}

src_install() {
	dodir /usr/share/doc/${PF}
	make DESTDIR=${D} install || die

	# Various symlinks normally created by unix/install-plucker.sh
	python_version
	dosym /usr/lib/python${PYVER}/site-packages/PyPlucker/Spider.py \
		/usr/bin/plucker-build
	dosym /usr/lib/python${PYVER}/site-packages/PyPlucker/Plucker-Docs.py \
		/usr/bin/plucker-decode
	dosym /usr/lib/python${PYVER}/site-packages/PyPlucker/Decode.py \
		/usr/bin/plucker-dump

	# Extra symlink
	dosym /usr/lib/python${PYVER}/site-packages/PyPlucker/pluck-comics.py /usr/bin/pluck-comics
}
