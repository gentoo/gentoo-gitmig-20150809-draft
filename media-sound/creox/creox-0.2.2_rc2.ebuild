# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/creox/creox-0.2.2_rc2.ebuild,v 1.9 2005/08/13 12:56:23 flameeyes Exp $

inherit kde eutils

MY_P=${P/_/}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="CREOX Real Time Effects Processor"
HOMEPAGE="http://www.uid0.sk/zyzstar/?creox"
SRC_URI="http://www.uid0.sk/zyzstar/projects/creox/downloads/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64"
IUSE=""

DEPEND="media-sound/jack-audio-connection-kit
	kde-base/arts"
need-kde 3

pkg_setup() {
	if ! built_with_use kdelibs arts ; then
		eerror "${CATEGORY}/${P} requires you to build kdelibs with arts useflag on."
		die
	fi
}

src_unpack() {
	kde_src_unpack

	cd ${S}
	epatch ${FILESDIR}/${P}-ebusy.patch
}
