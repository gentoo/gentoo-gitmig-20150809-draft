# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc-source/fpc-source-2.0.0_rc2.ebuild,v 1.1 2005/04/01 18:51:38 chriswhite Exp $

MY_P="1.9.8"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-FPC"
KEYWORDS="~x86 -amd64"
DESCRIPTION="Free Pascal Compiler Sources"
HOMEPAGE="http://www.freepascal.org/"
IUSE=""
SRC_URI="ftp://ftp.freepascal.org/pub/fpc/beta/source-${MY_P}/fpc-${MY_P}.source.tar.gz"
DEPEND=""
RDEPEND=""

S=${WORKDIR}/fpc

src_unpack () {
	unpack ${A} || die "Unpacking ${A} failed!"
}

src_compile () {
	einfo "Nothing to compile."
}

src_install () {
	# Do not slot this, do not use version strings in path, unless you symlink to a directory
	# Lazarus searches in. See top of include/unix/lazbaseconf.inc in Lazarus source.

	# Like "make sourceinstall" but path works with Lazarus, no "make distclean" (unneeded)
	diropts -m0755 || die "Unable to set diropts!"
	dodir /usr/lib/fpc/src || die "Unable to create /usr/lib/fpc/src/ !"
	einfo "Copying files. Please wait..."
	cp -Rfp . ${D}usr/lib/fpc/src || die "Unable to copy files!"
}

pkg_preinst () {
	# Some cleaning, sometimes there is weird stuff accidently packaged in the tarballs.
	# Happens more often with .o files, CVS directories are always in there - we don't want those.
	cd ${D}
	for EXT in ppu ppw ppl o ow rst cvsignore bak orig rej xvpics; do
		find . -name "*.$EXT" -exec rm -f {} \; || die "Unable to delete $EXT files"
	done
	find . -name "*.~*" -exec rm -f {} \; || die "Unable to delete .~* files!"
	find . -name "*.#*" -exec rm -f {} \; || die "Unable to delete .#* files!"
	find . -name "CVS" -depth -type d -exec rm -fr {} \; || die "Unable to delete CVS directories!"
	find . -perm +a+x -type f -exec rm -f {} \; || die "Unable to delete executables!"
}
