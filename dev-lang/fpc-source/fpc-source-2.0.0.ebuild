# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc-source/fpc-source-2.0.0.ebuild,v 1.1 2005/06/25 22:52:56 agriffis Exp $

# Needed to release candidates etc.
MY_PV="2.0.0"

SLOT="0" # Read src_install notes!
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-FPC"
KEYWORDS="~x86"
DESCRIPTION="Free Pascal Compiler Sources"
HOMEPAGE="http://www.freepascal.org/"
IUSE=""
SRC_URI="mirror://sourceforge/freepascal/fpc-${MY_PV}.source.tar.gz"
DEPEND="net-misc/rsync"
RDEPEND=""

src_install () {
	# Do not slot this, do not use version strings in path, unless you symlink
	# to a directory Lazarus searches in. See top of
	# include/unix/lazbaseconf.inc in Lazarus source.

	# Like "make sourceinstall" but path works with Lazarus, no "make distclean"
	# (unneeded)
	diropts -m0755
	dodir /usr/lib/fpc || die
	ebegin "Copying files"
	# Use rsync since cp doesn't support exclusions
	rsync -a \
		--exclude="*.#*" \
		--exclude="*.bak" \
		--exclude="*.cvsignore" \
		--exclude="*.o" \
		--exclude="*.orig" \
		--exclude="*.ow" \
		--exclude="*.ppl" \
		--exclude="*.ppu" \
		--exclude="*.ppw" \
		--exclude="*.rej" \
		--exclude="*.rst" \
		--exclude="*.xvpics" \
		--exclude="*.~*" \
		--exclude="CVS" \
		${WORKDIR}/fpc ${D}usr/lib/fpc/src 
	eend $? || die
}
