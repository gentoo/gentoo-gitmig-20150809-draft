# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kbear/kbear-2.0_alpha1.ebuild,v 1.4 2002/07/17 09:39:57 seemant Exp $

inherit kde-base || die

S=${WORKDIR}/kbear-2.0alpha1
DESCRIPTION="An FTP Manager"
SRC_URI="mirror://sourceforge/kbear/kbear-2.0alpha1.tar.bz2"
HOMEPAGE="http://kbear.sourceforge.net"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86"

need-kde 3

