# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kbear/kbear-2.0_beta1.ebuild,v 1.2 2002/08/16 14:24:48 murphy Exp $
inherit kde-base 

S=${WORKDIR}/kbear-2.0beta1
DESCRIPTION="An FTP Manager"
SRC_URI="mirror://sourceforge/kbear/kbear-2.0beta1.src.tar.bz2"
HOMEPAGE="http://kbear.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

need-kde 3

