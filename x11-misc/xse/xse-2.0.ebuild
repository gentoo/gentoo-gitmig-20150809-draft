# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xse/xse-2.0.ebuild,v 1.3 2005/03/21 13:01:31 taviso Exp $

inherit eutils

DESCRIPTION="Command Line Interface to XSendEvent() (useful for scripting interaction, debugging applications, experimenting with X11 events, etc.)"
HOMEPAGE="news://alt.sources/"

# The following posts to alt.sources make up this package:
#
# <1992Jan31.182036.26249@cs.rochester.edu>
# <1992Jan31.182224.26407@cs.rochester.edu>
# <1992Jan31.182450.26610@cs.rochester.edu>

SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="X11"
SLOT="0"
KEYWORDS="x86"

IUSE=""
DEPEND="virtual/x11"

src_unpack() {
	local i

	unpack ${A}
	cd ${S}

	einfo "Unpacking shar archives..."
		# this saves a dependency on sharutils
		for i in 1992Jan31.{182036.26249,182224.26407,182450.26610}
		do
			ebegin "	${i}@cs.rochester.edu"
				set -o pipefail
			sed '1,/^#!/d' ${i} | /bin/sh -s -- -c &> /dev/null || {
					eend $?
					die "failed to unpack shar archive"
			} && {
				eend $?
			}
				set +o pipefail
		done
	einfo "done."
	ebegin "Creating Makefiles"
	xmkmf -a &> /dev/null || {
		eend $?
		die "Building Makefiles failed"
	} && {
		eend $?
	}
}

src_compile() { emake CDEBUGFLAGS="${CFLAGS}" LOCAL_LDFLAGS=${LDFLAGS}; }

src_install() {
	dobin xse

	newman xse.man xse.1
	dodoc README test-events

	dodir /usr/X11R6/lib/X11/app-defaults
	insinto /usr/X11R6/lib/X11/app-defaults
	newins Xse.ad Xse
}
