# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift-fasttrack-cvs/gift-fasttrack-cvs-0.8.1.ebuild,v 1.3 2003/07/21 11:09:05 seemant Exp $

DESCRIPTION="FastTrack Plugin for giFT"
HOMEPAGE="https://developer.berlios.de/projects/gift-fasttrack/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

DEPEND=">=sys-devel/automake-1.7
	virtual/glibc
	!net-p2p/gift-fasttrack
	>=net-p2p/gift-0.11.1
	>=sys-apps/sed-4
	>=sys-libs/zlib-1.1.4"

inherit cvs debug flag-o-matic

strip-flags

# CVS settings for giFT-FastTrack
ECVS_SERVER="cvs.gift-fasttrack.berlios.de:/cvsroot/gift-fasttrack"
ECVS_MODULE="giFT-FastTrack"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/gift-fasttrack-cvs"
S=${WORKDIR}/${ECVS_MODULE}

src_compile() {

	# Compile the FastTrack plugin. The developers of this thing sure as hell
	# don't like automated installs.

	# It needs automake-1.7
	export WANT_AUTOMAKE=1.7
	cd ${S}
	cp /usr/share/libtool/ltmain.sh .
	./autogen.sh --prefix=/usr --host=${CHOST} || die "FastTrack configure failed"
	emake || die "FastTrack plugin failed to build"

}

src_install() {

	# Install the FastTrack plugin.
	cd ${S}
	make DESTDIR="${D}" install || "FastTrack plugin failed to install"

}

pkg_postinst() {
	einfo "To run giFT with FastTrack support, run:"
	einfo "giFT -p /usr/lib/giFT/libFastTrack.so"
	echo
	einfo "Alternatively you can add the following line to"
	einfo "your ~/.giFT/gift.conf configuration file:"
	einfo "plugins = OpenFT:FastTrack"
}

