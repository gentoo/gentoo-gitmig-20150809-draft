# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit kde-base || die

S="${WORKDIR}/kphone-1.0"
need-kde 3
LICENSE="GPL-2"
DESCRIPTION="a SIP user agent for Linux, with which you can initiate VoIP connections over the Internet."
SRC_URI="http://www.wirlab.net/kphone/kphone-1.0.2.tgz"
HOMEPAGE="http://www.wirlab.net/kphone/index.html"
KEYWORDS="x86 sparc sparc64"

# Fix for our kde location
myconf="$myconf --with-extra-libs=$KDEDIR/lib"
