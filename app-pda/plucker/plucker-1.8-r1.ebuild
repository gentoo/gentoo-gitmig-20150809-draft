# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/plucker/plucker-1.8-r1.ebuild,v 1.9 2006/12/09 20:19:37 dirtyepic Exp $

IUSE="gtk"

inherit python eutils wxwidgets

DESCRIPTION="Distiller for Plucker -- offline ebook reader for Palm devices"
HOMEPAGE="http://www.plkr.org/"
SRC_URI="http://downloads.plkr.org/${PV}/${PN}_src-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
DEPEND=">=dev-lang/python-1.5.2
	gtk? ( >=x11-libs/gtk+-2.2
		=x11-libs/wxGTK-2.4* )
	sys-devel/autoconf"
RDEPEND=">=dev-lang/python-1.5.2
	gtk? ( >=x11-libs/gtk+-2.2
		=x11-libs/wxGTK-2.4* )
	|| (
		>=media-gfx/imagemagick-5.4.4
		>=dev-python/imaging-1.1
		>=media-libs/netpbm-9.15
	)"

src_unpack() {
	unpack ${A}
	cd ${S} || die

	# Repair broken Makefile.in
	epatch ${FILESDIR}/plucker-1.8-Makefile.in.patch

	# GCC 4 - extra qualification - Bug #138370
	epatch "${FILESDIR}"/${P}-gcc4.patch

	# Repair documentation installation path
	sed -i "/^DOCSDIR/s/packages/${PF}/" plucker_desktop/Makefile.in || die "sed 1 failed"

	# Fix default path to netpbm files
	sed -i "s:, '\(palm.*\.map\):, '/usr/share/netpbm/\1:p" \
		parser/python/PyPlucker/ImageParser.py || die "sed 2 failed"

	# Fix deprecation warnings for python-2.3
	sed -i "s:0x\w\w\w\w\w\w\w\w:&L:" \
		parser/python/PyPlucker/helper/gettext.py || die "sed 3 failed"

	# Get the right version of wxGTK (note call to need-wxwidgets below)
	find . -name Makefile.in | xargs sed -i 's/wx-config/$(WX_CONFIG)/g' \
		|| die "sed 4 failed"
}

src_compile() {
	# plucker-desktop doesn't build with the unicode version of wxGTK.  Force
	# the non-unicode version until plucker-desktop is fixed.  #55716
	if useq gtk; then
		need-wxwidgets gtk2
	fi

	# --enable-desktopbuild and --disable-desktopbuild are equivalent for this
	# package; either one will *disable* the desktopbuild.  It is enabled only
	# if the flags are lacking from the cmdline.  (21 Jun 2004 agriffis)
	econf \
		$(useq gtk || echo --disable-desktopbuild --disable-gtkviewer) \
		--disable-palmosbuild \
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
