# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kbear/kbear-2.0_beta2.ebuild,v 1.2 2002/08/29 20:38:20 danarmak Exp $
inherit kde-base 

S=${WORKDIR}/kbear-2.0beta2
DESCRIPTION="An FTP Manager"
SRC_URI="mirror://sourceforge/kbear/kbear-2.0beta2.src.tar.bz2"
HOMEPAGE="http://kbear.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="x86"

need-kde 3

# uses xml2pot
newdepend ">=kde-base/kdesdk-3"
