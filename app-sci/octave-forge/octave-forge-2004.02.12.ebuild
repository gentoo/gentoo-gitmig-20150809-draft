# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/octave-forge/octave-forge-2004.02.12.ebuild,v 1.2 2004/03/17 21:53:29 aliz Exp $

inherit eutils

DESCRIPTION="A collection of custom scripts, functions and extensions for GNU Octave"
HOMEPAGE="http://octave.sourceforge.net/"
SRC_URI="mirror://sourceforge/octave/${P}.tar.gz"

LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
SLOT="0"
IUSE="ginac qhull"

DEPEND=">=app-sci/octave-2.1.40
		>=sys-apps/sed-4
		sys-libs/libtermcap-compat
		!amd64? ( ginac? ( app-sci/ginac ) )
		qhull? ( >=media-libs/qhull-3.1-r1 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e 's:a"key":a["key"]:' -i configure || die "sed failed on configure"
	sed -e 's:\(^man1dir = \):\1$(DESTDIR)/:; s:$(bindir):$(DESTDIR)/$(bindir):' -i extra/mex/Makefile \
		|| die "sed failed on mex/Makefile"

	epatch ${FILESDIR}/${P}-fPIC.patch
}

src_compile() {
	econf || die "econf failed"

	# The *XPATH variables need to be changed, or they will
	# cause Portage access violations. They cannot be easily set just using
	# arguments passed to ./configure (at least, they can not easily be set
	# correctly)
	echo -en "Modifying paths..."
	for path in M O X ALTM ALTO; do
		sed -i "s|^\(${path}PATH = \)|\1${D}|" Makeconf || \
			die "failed to modify ${path}PATH"
	done
	echo -e "done.\n"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

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

