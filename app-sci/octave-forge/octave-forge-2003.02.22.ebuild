# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/octave-forge/octave-forge-2003.02.22.ebuild,v 1.1 2003/06/09 21:53:15 george Exp $

DESCRIPTION="A collection of custom scripts, functions and extensions for GNU Octave"
HOMEPAGE="http://octave.sourceforge.net/"
SRC_URI="mirror://sourceforge/octave/${P}.tar.gz"

LICENSE="as-is"
# I have only tested this library on x86
KEYWORDS="~x86"
SLOT="0"
IUSE="ginac qhull"

DEPEND=">=app-sci/octave-2.1.44
		sys-libs/libtermcap-compat
		ginac? ( app-sci/ginac )
		qhull? ( >=media-libs/qhull-3.1-r1 )"


src_compile() {
	econf || die "econf failed"

	# The MPATH, OPATH, and XPATH variables need to be changed, or they will
	# cause Portage access violations. They cannot be easily set just using
	# arguments passed to ./configure (at least, they can not easily be set
	# correctly)
	echo -en "Modifying paths..."
	sed -i "s|^\(MPATH = \)|\1${D}|" Makeconf || die "failed to modify MPATH"
	sed -i "s|^\(OPATH = \)|\1${D}|" Makeconf || die "failed to modify OPATH"
	sed -i "s|^\(XPATH = \)|\1${D}|" Makeconf || die "failed to modify XPATH"
	echo -e "done.\n"

	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	# strip the fudged install paths
	sed -i "s|${D}||g" ${D}/usr/bin/mex || die "sed failed"

	dodoc AUTHORS COPYING* ChangeLog INDEX RELEASE-NOTES TODO
}

pkg_postinst() {
	einfo "If you do not have GiNaC and Qhull installed, octave-forge did not"
	einfo "compile itself with support for the geometry and symbolic math"
	einfo "extensions. If you would like these features, please emerge ginac"
	einfo "and/or qhull and then re-emerge octave-forge. Alternately, you can"
	einfo "specify USE='ginac qhull' and re-emerge octave-forge; in that case"
	einfo "the ebuild will automatically install the additional packages."
}

