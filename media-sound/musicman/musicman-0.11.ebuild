# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musicman/musicman-0.11.ebuild,v 1.1 2004/07/07 21:20:18 fvdpol Exp $

inherit kde

DESCRIPTION="A Konqueror plugin for manipulating ID3 tags in MP3 files"
HOMEPAGE="http://musicman.sourceforge.net/"
SRC_URI="mirror://sourceforge/musicman/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=kde-base/kdebase-3.2.1 \
	>=media-libs/jpeg-6b-r3 \
	>=app-admin/fam-2.7.0 \
	>=media-libs/libart_lgpl-2.3.16"

# The tar.gz doesn't create a musicman-0.11 directory
S="${WORKDIR}/musicman"

# Use the compile function from the kde eclass which gets rid
# of the sandbox 'access denied' errors

# Can't use the kde install function; it puts things in /share
# for some reason (presumably doesn't define prefix)
src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
}
