# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nvtv/nvtv-0.4.4.ebuild,v 1.1 2003/06/18 11:59:23 seemant Exp $

IUSE="X gtk gtk2"

S=${WORKDIR}/${PN}
DESCRIPTION="TV-Out for NVidia cards"
HOMEPAGE="http://sourceforge.net/projects/nv-tv-out/"
SRC_URI="mirror://sourceforge/nv-tv-out/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="sys-apps/pciutils
	gtk? ( =x11-libs/gtk+-1.2* )
	gtk2? ( =x11-libs/gtk+-2* )
	X? ( >=x11-base/xfree-4.0 )"

src_compile() {
	local myconf

	if use gtk2; then
		myconf="${myconf} --with-gtk=gtk2"
	elif use gtk; then
		myconf="${myconf} --with-gtk=gtk1"
	else
		myconf="${myconf} --without-gtk";
	fi

	use X && myconf="${myconf} --with-x" || myconf="${myconf} --without-x"

	econf ${myconf}

	# The CFLAGS don't seem to make it into the Makefile.
	cd src
	emake CXFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin src/nvtv
	dosbin src/nvtvd

	dodoc ANNOUNCE BUGS FAQ INSTALL README \
		doc/USAGE doc/chips.txt doc/overview.txt \
		doc/timing.txt xine/tvxine

	exeinto /etc/init.d
	newexe ${FILESDIR}/nvtv.start nvtv
}
