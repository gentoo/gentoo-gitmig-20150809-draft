# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kbear/kbear-2.0_alpha1.ebuild,v 1.1 2002/06/18 10:21:04 bangert Exp $

inherit kde-base || die

S=${WORKDIR}/kbear-2.0alpha1

DESCRIPTION="An FTP Manager"
SRC_URI="http://us.dl.sourceforge.net/kbear/kbear-2.0alpha1.tar.bz2"
HOMEPAGE="http://kbear.sourceforge.net"
LICENSE="GPL-2"
SLOT="2"

need-kde 3

