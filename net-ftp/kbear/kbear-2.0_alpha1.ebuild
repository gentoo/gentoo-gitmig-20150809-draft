# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kbear/kbear-2.0_alpha1.ebuild,v 1.3 2002/07/11 06:30:46 drobbins Exp $

inherit kde-base || die

S=${WORKDIR}/kbear-2.0alpha1
LICENSE="GPL-2"
DESCRIPTION="An FTP Manager"
SRC_URI="http://us.dl.sourceforge.net/kbear/kbear-2.0alpha1.tar.bz2"
HOMEPAGE="http://kbear.sourceforge.net"
LICENSE="GPL-2"
SLOT="2"

need-kde 3

