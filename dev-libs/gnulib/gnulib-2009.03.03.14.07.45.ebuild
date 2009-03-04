# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gnulib/gnulib-2009.03.03.14.07.45.ebuild,v 1.2 2009/03/04 15:37:25 drizzt Exp $

inherit eutils

DESCRIPTION="Gnulib is a library of common routines intended to be shared at the source level."
HOMEPAGE="http://www.gnu.org/software/gnulib"

# This tar.gz is created on-the-fly when downloaded from
# http://git.savannah.gnu.org/gitweb/?p=gnulib.git;a=snapshot;h=${GNULIB_COMMIT_GITID};sf=tgz
# So to have persistent checksums, we need to download once and cache it.
#
# To get a new version, download a "snapshot" from
# http://git.savannah.gnu.org/gitweb/?p=gnulib.git
# take the commit-id as GNULIB_COMMIT_GITID
# and the committer's timestamp (not the author's one), year to second, UTC
# as the ebuild version.
#
# To see what the last commit message for the current version was, use
# http://git.savannah.gnu.org/gitweb/?p=gnulib.git;a=commit;h=${GNULIB_COMMIT_GITID}
#
GNULIB_COMMIT_GITID=8d2524ce78ca107074727cbd8780c26a203a107c
SRC_URI="http://dev.gentoo.org/~drizzt/distfiles/${PN}-${GNULIB_COMMIT_GITID}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86-fbsd"
IUSE="doc"

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}" || die
	epatch "${FILESDIR}"/${PN}-2008.07.23-rpl_getopt.patch
	epatch "${FILESDIR}"/${P}-scandir.patch

	# Remove the broken pxref
	sed -i '$d' doc/ld-version-script.texi || die "cannot fix ld-version-script.texi"
}

src_compile() {
	if use doc; then
		emake -C doc info html || die "emake failed"
	fi
}

src_install() {
	dodoc README ChangeLog
	if use doc; then
		dohtml doc/gnulib.html
		doinfo doc/gnulib.info
	fi

	insinto /usr/share/${PN}
	doins -r lib
	doins -r m4
	doins -r modules
	doins -r build-aux
	doins -r top

	# install the real script
	exeinto /usr/share/${PN}
	doexe gnulib-tool

	# create and install the wrapper
	dosym /usr/share/${PN}/gnulib-tool /usr/bin/gnulib-tool
}
